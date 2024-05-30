import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/domain/models/task.dart'; // Asegúrate de importar correctamente tu clase Task

void main() {
  group('Task', () {
    test('supports value equality', () {
      expect(
        const Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'new'),
        const Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'new'),
      );
    });

    test('props are correct', () {
      expect(
        const Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'new').props,
        ['1', 'Task 1', 'Description 1', 'new'],
      );
    });

    test('copyWith creates a copy with updated values', () {
      const task = Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'new');
      final updatedTask = task.copyWith(title: 'Updated Task 1');

      expect(updatedTask.title, 'Updated Task 1');
      expect(updatedTask.id, '1');
      expect(updatedTask.desc, 'Description 1');
      expect(updatedTask.state, 'new');
    });

    test('copyWith without arguments returns the same object', () {
      const task = Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'new');
      final sameTask = task.copyWith();

      expect(sameTask, task);
    });
  });
}
