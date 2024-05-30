import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String desc;
  final String state;

  const Task({
    required this.id,
    required this.title,
    required this.desc,
    required this.state,
  });

  Task copyWith({
    String? id,
    String? title,
    String? desc,
    String? state,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [id, title, desc, state];
}
