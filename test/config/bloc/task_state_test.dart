import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/config/bloc/task_bloc.dart';
import 'package:seektest/domain/models/task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {

  setUpAll(() {
    // Inicializa databaseFactory para sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('TaskState', () {
    test('equatable properties', () {
      final taskState1 = TaskState(taskModel: []);
      final taskState2 = TaskState(taskModel: []);
      final taskState3 = TaskState(taskModel: [Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'pending')]);

      // Comprueba que dos estados vacíos sean iguales
      expect(taskState1, equals(taskState2));

      // Comprueba que dos estados con diferentes modelos de tarea sean diferentes
      expect(taskState1, isNot(equals(taskState3)));

      // Comprueba que las propiedades Equatable funcionan correctamente
      expect(taskState1.props, equals(taskState2.props));
      expect(taskState1.props, isNot(equals(taskState3.props)));
    });

    test('copyWith method', () {
      final taskState = TaskState(taskModel: []);
      final updatedTaskModel = [Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'pending')];

      // Utiliza el método copyWith para crear un nuevo estado con un modelo de tarea actualizado
      final newState = taskState.copyWith(taskModel: updatedTaskModel);

      // Comprueba que el nuevo estado tenga el modelo de tarea actualizado
      expect(newState.taskModel, equals(updatedTaskModel));

      // Comprueba que el nuevo estado sea diferente al estado original
      expect(newState, isNot(equals(taskState)));
    });
  });
}
