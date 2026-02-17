import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repository/forget_password_repository.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';

import 'reset_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late ResetPasswordUseCase useCase;
  late MockForgetPasswordRepository mockRepository;

  setUp(() {
    mockRepository = MockForgetPasswordRepository();
    useCase = ResetPasswordUseCase(mockRepository);
  });

  const tRequest = ResetPasswordRequestModel(
    email: 'test@example.com',
    newPassword: 'password123',
  );

  test('should call resetCode on the repository', () async {
    // arrange
    when(
      mockRepository.resetCode(any),
    ).thenAnswer((_) async => const BaseResponse<void>.success(null));

    // act
    final result = await useCase(tRequest);

    // assert
    expect(result, const BaseResponse<void>.success(null));
    verify(mockRepository.resetCode(tRequest));
    verifyNoMoreInteractions(mockRepository);
  });
}
