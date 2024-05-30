import 'package:seektest/domain/models/gateway/task.dart';
import 'package:seektest/domain/models/task.dart';

class TaskDataUseCase{
  final TaskDataGateway taskDataGateway;
  TaskDataUseCase(this.taskDataGateway);
  Future<List<Task>> getTaskData(query) => taskDataGateway.getTaskData(query);
  Future<Task> getTaskDetail(id) => taskDataGateway.getTaskDetail(id);
}