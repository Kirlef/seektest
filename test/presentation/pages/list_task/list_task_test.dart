import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/config/bloc/task_bloc.dart';
import 'package:seektest/config/routes/app_routes.dart';
import 'package:seektest/domain/models/task.dart';
import 'package:seektest/presentation/pages/list_task/list_task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('HomeScreen Widget Tests', () {
    late TaskBloc taskBloc;

    setUp(() async {
      final Map<String, Object> values = <String, Object>{'filter': 'pending'};
      SharedPreferences.setMockInitialValues(values);

      taskBloc = TaskBloc();
      taskBloc.emit(TaskState(taskModel: [
        Task(id: '1456', title: 'Task 1', desc: 'Desc 1', state: 'pending'),
        Task(id: '2345', title: 'Task 2', desc: 'Desc 2', state: 'done'),
      ]));
    });

    tearDown(() {
      taskBloc.close();
    });

    testWidgets('displays tasks and responds to events', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.add: (context) => Scaffold(body: Text('Add Task Screen')),
          },
          home: BlocProvider.value(
            value: taskBloc,
            child: HomeScreen(),
          ),
        ),
      );

      // Verify that the tasks are displayed
      expect(find.text('Task 1'), findsOneWidget);
    //  expect(find.text('Task 2'), findsOneWidget);

      // Verify that the buttons are working
      await tester.tap(find.text('Done'));
      await tester.pump();
      // Aquí deberías agregar la verificación de que se añadió el evento correcto al bloc

      await tester.tap(find.text('Pending'));
      await tester.pump();
      // Aquí deberías agregar la verificación de que se añadió el evento correcto al bloc

      // Verify that floating action button navigates to AddTaskScreen
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text('Add Task Screen'), findsOneWidget);
    });

    testWidgets('responds to delete action', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: taskBloc,
            child: HomeScreen(),
          ),
        ),
      );

      // Verify that the task is displayed
      expect(find.text('Task 1'), findsOneWidget);

      // Simulate swipe to reveal delete action
      await tester.drag(find.text('Task 1'), Offset(-500, 0));
      await tester.pumpAndSettle();

      // Tap delete action
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      // Aquí deberías agregar la verificación de que se añadió el evento correcto al bloc
    });
  });
}
