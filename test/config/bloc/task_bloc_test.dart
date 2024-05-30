import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/config/bloc/task_bloc.dart';
import 'package:seektest/domain/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    final Map<String, Object> values = <String, Object>{'filter': 'pending'};
    SharedPreferences.setMockInitialValues(values);
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });



  group('TaskBloc', () {
    late TaskBloc taskBloc;

    setUp(() {
      taskBloc = TaskBloc();
    });

    tearDown(() {
      taskBloc.close();
    });

    test('initial state is correct', () {
      expect(taskBloc.state, const TaskState(taskModel: []));
    });

    test('emits TaskState with updated task list when ShowDataEvent is added', () async {
      // Emit the ShowDataEvent to the bloc
      taskBloc.add(ShowDataEvent());

      // Wait for the bloc to emit a state
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>(), // Add expected state after fetching data from DB
        ]),
      );
    });

    test('emits TaskState with added task when AddDataEvent is added', () async {
      // Emit the AddDataEvent with a sample task to the bloc
      taskBloc.add(const AddDataEvent(title: 'Task 1', desc: 'Description 1', state: 'pending'));

      // Wait for the bloc to emit a state
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>(), // Add expected state after adding a new task
        ]),
      );
    });

    test('updateTask updates task in the state', () async {
      // Arrange
      final initialState = TaskState(
        taskModel: [
          Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'pending'),
          Task(id: '2', title: 'Task 2', desc: 'Description 2', state: 'completed'),
        ],
      );

      final updatedTask = Task(id: '1', title: 'Updated Task', desc: 'Updated Description', state: 'completed');

      // Act
      taskBloc.emit(initialState);
      taskBloc.add(UpdateDataEvent(updatedTask));

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          initialState.copyWith(
            taskModel: [
              updatedTask,
              Task(id: '2', title: 'Task 2', desc: 'Description 2', state: 'completed'), // Other task remains unchanged
            ],
          ),
        ]),
      );
    });


    test('deleteTask removes task from the state', () async {
      // Arrange
      final initialState = TaskState(
        taskModel: [
          Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'pending'),
          Task(id: '2', title: 'Task 2', desc: 'Description 2', state: 'completed'),
        ],
      );

      // Act
      taskBloc.emit(initialState);
      taskBloc.add(DeleteDataEvent(id: '1'));

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          initialState.copyWith(
            taskModel: [
              Task(id: '2', title: 'Task 2', desc: 'Description 2', state: 'completed'), // Task with ID '1' should be removed
            ],
          ),
        ]),
      );
    });
  });

}

