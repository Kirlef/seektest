// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:seektest/app/app.dart';
// import 'package:seektest/config/bloc/task_bloc.dart';
// import 'package:seektest/config/routes/app_routes.dart';
// import 'package:seektest/ui/pages/add_task.dart';
// import 'package:seektest/ui/pages/list_task.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mockito/mockito.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//
// // Mock the TodoBloc for testing purposes
// class MockTaskBloc extends Mock implements TaskBloc {}
//
// void main() {
//   setUpAll(() {
//     registerFallbackValue(MockTaskBloc());
//
//     sqfliteFfiInit();
//     databaseFactory = databaseFactoryFfi;
//   });
//
//   testWidgets('App initializes with HomeScreen', (WidgetTester tester) async {
//     await tester.pumpWidget(const App());
//
//     expect(find.byType(HomeScreen), findsOneWidget);
//   });
//
//   testWidgets('Navigates to AddTaskScreen', (WidgetTester tester) async {
//     await tester.pumpWidget(const App());
//
//     final addTaskButton = find.byIcon(Icons.add);
//     expect(addTaskButton, findsOneWidget);
//
//     await tester.tap(addTaskButton);
//     await tester.pumpAndSettle();
//
//     expect(find.byType(AddTaskScreen), findsOneWidget);
//   });
//
//   testWidgets('App provides TodoBloc', (WidgetTester tester) async {
//     await tester.pumpWidget(const App());
//
//     expect(find.byType(BlocProvider<TaskBloc>), findsOneWidget);
//   });
//
//   testWidgets('Navigates to HomeScreen when AppRoutes.home is called', (WidgetTester tester) async {
//     // Build the MaterialApp with the App widget
//     await tester.pumpWidget(const App());
//
//     // Verify that HomeScreen is displayed by default
//     expect(find.byType(HomeScreen), findsOneWidget);
//
//     // Define the Navigator to push the AppRoutes.home route
//     Navigator.of(tester.element(find.byType(HomeScreen))).pushNamed(AppRoutes.home);
//
//     // Rebuild the widget after the state has changed
//     await tester.pumpAndSettle();
//
//     // Verify that HomeScreen is still displayed
//     expect(find.byType(HomeScreen), findsOneWidget);
//   });
//
//   testWidgets('Navigates to AddTaskScreen when AppRoutes.add is called', (WidgetTester tester) async {
//     // Build the MaterialApp with the App widget
//     await tester.pumpWidget(const App());
//
//     // Verify that HomeScreen is displayed by default
//     expect(find.byType(HomeScreen), findsOneWidget);
//
//     // Navigate to AddTaskScreen using the AppRoutes.add route
//     Navigator.of(tester.element(find.byType(HomeScreen))).pushNamed(AppRoutes.add);
//
//     // Rebuild the widget after the state has changed
//     await tester.pumpAndSettle();
//
//     // Verify that AddTaskScreen is displayed
//     expect(find.byType(AddTaskScreen), findsOneWidget);
//   });
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/app/app.dart';
import 'package:seektest/config/bloc/task_bloc.dart';
import 'package:seektest/config/routes/app_routes.dart';
import 'package:seektest/presentation/pages/add_task/add_task.dart';
import 'package:seektest/presentation/pages/list_task/list_task.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  testWidgets('App initializes with HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navigates to AddTaskScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    final addTaskButton = find.byIcon(Icons.add);
    expect(addTaskButton, findsOneWidget);

    await tester.tap(addTaskButton);
    await tester.pumpAndSettle();

    expect(find.byType(AddTaskScreen), findsOneWidget);
  });

  testWidgets('App provides TaskBloc', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Esperar un frame para permitir que los widgets se construyan.
    await tester.pump();

    expect(find.byType(BlocProvider<TaskBloc>), findsOneWidget);
  });

  testWidgets('Navigates to HomeScreen when AppRoutes.home is called', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(HomeScreen), findsOneWidget);

    Navigator.of(tester.element(find.byType(HomeScreen))).pushNamed(AppRoutes.home);

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navigates to AddTaskScreen when AppRoutes.add is called', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.byType(HomeScreen), findsOneWidget);

    Navigator.of(tester.element(find.byType(HomeScreen))).pushNamed(AppRoutes.add);

    await tester.pumpAndSettle();

    expect(find.byType(AddTaskScreen), findsOneWidget);
  });
}

