import 'package:flutter_test/flutter_test.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/mappers/change_password_request_mapper.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/data/models/change_password_request_model.dart';
import 'package:tracking_app/features/taps/profile_tab/change_password/domain/entities/change_password_request_entity.dart';

void main() {
  group('ChangePasswordRequestMapper', () {
    test(
      'should map ChangePasswordRequestEntity to ChangePasswordRequestModel correctly',
      () {
        // Arrange
        const entity = ChangePasswordRequestEntity(
          password: 'oldPassword123',
          newPassword: 'newPassword123',
        );
        const expectedModel = ChangePasswordRequestModel(
          password: 'oldPassword123',
          newPassword: 'newPassword123',
        );

        // Act
        final result = entity.toModel();

        // Assert
        expect(result, equals(expectedModel));
      },
    );

    test('should map entity with empty strings correctly', () {
      // Arrange
      const entity = ChangePasswordRequestEntity(password: '', newPassword: '');
      const expectedModel = ChangePasswordRequestModel(
        password: '',
        newPassword: '',
      );

      // Act
      final result = entity.toModel();

      // Assert
      expect(result, equals(expectedModel));
    });

    test('should map entity with special characters correctly', () {
      // Arrange
      const entity = ChangePasswordRequestEntity(
        password: 'p@ssw0rd!#\$%',
        newPassword: 'n3wP@ss!&*()',
      );
      const expectedModel = ChangePasswordRequestModel(
        password: 'p@ssw0rd!#\$%',
        newPassword: 'n3wP@ss!&*()',
      );

      // Act
      final result = entity.toModel();

      // Assert
      expect(result, equals(expectedModel));
    });

    test('should map entity with very long passwords correctly', () {
      // Arrange
      final longPassword = 'a' * 100;
      final entity = ChangePasswordRequestEntity(
        password: longPassword,
        newPassword: longPassword,
      );
      final expectedModel = ChangePasswordRequestModel(
        password: longPassword,
        newPassword: longPassword,
      );

      // Act
      final result = entity.toModel();

      // Assert
      expect(result, equals(expectedModel));
    });

    test('should map entity with unicode characters correctly', () {
      // Arrange
      const entity = ChangePasswordRequestEntity(
        password: '密码123',
        newPassword: 'пароль456',
      );
      const expectedModel = ChangePasswordRequestModel(
        password: '密码123',
        newPassword: 'пароль456',
      );

      // Act
      final result = entity.toModel();

      // Assert
      expect(result, equals(expectedModel));
    });

    test('should map entity with spaces correctly', () {
      // Arrange
      const entity = ChangePasswordRequestEntity(
        password: 'password with spaces',
        newPassword: 'new password with spaces',
      );
      const expectedModel = ChangePasswordRequestModel(
        password: 'password with spaces',
        newPassword: 'new password with spaces',
      );

      // Act
      final result = entity.toModel();

      // Assert
      expect(result, equals(expectedModel));
    });
  });
}
