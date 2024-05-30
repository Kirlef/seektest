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

  group('TaskEvent', () {
    test('ShowDataEvent should be equatable', () {
      final event1 = ShowDataEvent();
      final event2 = ShowDataEvent();

      expect(event1, equals(event2));
      expect(event1.props, equals(event2.props));
    });

    test('AddDataEvent should be equatable', () {
      final event1 = AddDataEvent(title: 'Task 1', desc: 'Description 1', state: 'pending');
      final event2 = AddDataEvent(title: 'Task 1', desc: 'Description 1', state: 'pending');

      expect(event1, equals(event2));
      expect(event1.props, equals(event2.props));
    });

    test('UpdateDataEvent should be equatable', () {
      final task = Task(id: '1', title: 'Task 1', desc: 'Description 1', state: 'pending');
      final event1 = UpdateDataEvent(task);
      final event2 = UpdateDataEvent(task);

      expect(event1, equals(event2));
      expect(event1.props, equals(event2.props));
    });

    test('DeleteDataEvent should be equatable', () {
      final event1 = DeleteDataEvent(id: '1');
      final event2 = DeleteDataEvent(id: '1');

      expect(event1, equals(event2));
      expect(event1.props, equals(event2.props));
    });

    group('AddDataEvent', () {
      test('copyWith returns a new instance with updated fields', () {
        // Arrange
        final originalEvent = AddDataEvent(title: 'Original Title', desc: 'Original Desc', state: 'pending');

        // Act
        final copiedEvent = originalEvent.copyWith(title: 'Updated Title');

        // Assert
        expect(copiedEvent.title, 'Updated Title');
        expect(copiedEvent.desc, 'Original Desc'); // Desc should remain unchanged
        expect(copiedEvent.state, 'pending'); // State should remain unchanged
      });
    });

    group('DeleteDataEvent', () {
      test('copyWith returns a new instance with updated id', () {
        // Arrange
        final originalEvent = DeleteDataEvent(id: 'Original ID');

        // Act
        final copiedEvent = originalEvent.copyWith(id: 'Updated ID');

        // Assert
        expect(copiedEvent.id, 'Updated ID');
      });
    });
  });
}
