import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seektest/config/bloc/task_bloc.dart';
import 'package:seektest/config/routes/app_routes.dart';
import 'package:seektest/presentation/pages/add_task/add_task.dart';
import 'package:seektest/presentation/pages/list_task/list_task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('AddTaskScreen widget tests', () {
    late TaskBloc taskBloc;

    setUp(() {
      taskBloc = TaskBloc();
    });

    tearDown(() {
      taskBloc.close();
    });



    testWidgets('AddTaskScreen should display properly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AddTaskScreen(),
          routes: {
            AppRoutes.home: (context) => Container(), // Mock route
          },
        ),
      );

      expect(find.text('Add Task Screen'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AddTaskScreen should validate form and add task', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TaskBloc>(
            create: (context) => taskBloc,
            child: AddTaskScreen(),
          ),
          routes: {
            AppRoutes.home: (context) => Container(), // Mock route
          },
        ),
      );

      // Simulate user input
      await tester.enterText(find.byType(TextFormField).first, 'Task title');
      await tester.enterText(find.byType(TextFormField).last, 'Task description');

      // Tap on the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that the add data event is called
   //   expect(taskBloc.state, emits(isA<TaskState>()));

      // Verify that the navigation occurs
     // expect(find.byType(HomeScreen() as Type), findsOneWidget);
    });
  });
}
