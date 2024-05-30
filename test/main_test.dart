import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/app/app.dart';
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

  testWidgets('App initializes and displays HomeScreen by default', (WidgetTester tester) async {
    // Build the App widget and trigger a frame
    await tester.pumpWidget(const App());

    // Verify that HomeScreen is displayed
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Navigates to AddTaskScreen when AppRoutes.add is called', (WidgetTester tester) async {
    // Build the App widget and trigger a frame
    await tester.pumpWidget(const App());

    // Verify that HomeScreen is displayed by default
    expect(find.byType(HomeScreen), findsOneWidget);

    // Navigate to AddTaskScreen using the AppRoutes.add route
    Navigator.of(tester.element(find.byType(HomeScreen))).pushNamed(AppRoutes.add);

    // Rebuild the widget after the state has changed
    await tester.pumpAndSettle();

    // Verify that AddTaskScreen is displayed
    expect(find.byType(AddTaskScreen), findsOneWidget);
  });
}
