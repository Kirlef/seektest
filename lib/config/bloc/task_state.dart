part of 'task_bloc.dart';

class TaskState extends Equatable {
  final List<Task> taskModel;

  const TaskState({required this.taskModel});

  @override
  List<Object?> get props => [taskModel];

  TaskState copyWith({required List<Task> taskModel}) {
    return TaskState(taskModel: taskModel);
  }
}
