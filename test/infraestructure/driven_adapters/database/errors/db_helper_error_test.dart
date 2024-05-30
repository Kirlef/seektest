import 'package:flutter_test/flutter_test.dart';
import 'package:seektest/infraestructure/driven_adapter/database/errors/db_helper_error.dart';

void main() {
  group('DbHelperError', () {
    test('toString returns correct error message', () {
      // Arrange
      final dbHelperError = DbHelperError();

      // Act
      final errorMessage = dbHelperError.toString();

      // Assert
      expect(errorMessage, 'Error in process of database');
    });
  });
}
