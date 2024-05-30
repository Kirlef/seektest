part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class ShowDataEvent extends TaskEvent {

  @override
  List<Object?> get props => [];

}

class AddDataEvent extends TaskEvent {
  final String title;
  final String desc;
  final String state;

  const AddDataEvent({
    required this.title,
    required this.desc,
    required this.state,
  });

  @override
  List<Object> get props => [title, desc, state];

  AddDataEvent copyWith({
    String? title,
    String? desc,
    String? state,
  }) {
    return AddDataEvent(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      state: state ?? this.state,
    );
  }
}

class UpdateDataEvent extends TaskEvent {
  final Task taskList;

  const UpdateDataEvent(this.taskList);

  @override
  List<Object?> get props => [taskList];
}



class DeleteDataEvent extends TaskEvent {
  final String id;

  const DeleteDataEvent({required this.id});

  DeleteDataEvent copyWith({String? id}) {
    return DeleteDataEvent(id: id ?? this.id);
  }

  @override
  List<Object> get props => [id];
}
