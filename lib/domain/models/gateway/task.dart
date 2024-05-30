import '../task.dart';

abstract class TaskDataGateway {
  Future<List<Task>> getTaskData(String query);
  Future<Task> getTaskDetail(String id);
}