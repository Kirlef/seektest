import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/config/routes/app_routes.dart';

void main() {
  test('AppRoutes constants are correct', () {
    // Test the value of home constant
    expect(AppRoutes.home, 'home');

    // Test the value of add constant
    expect(AppRoutes.add, 'add');
  });
}
