import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repository/forget_password_repository.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/forget_password_use_case.dart';

import 'forget_password_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late ForgetPasswordUseCase useCase;
  late MockForgetPasswordRepository mockRepository;

  setUp(() {
    mockRepository = MockForgetPasswordRepository();
    useCase = ForgetPasswordUseCase(mockRepository);
  });

  const tEmail = 'test@example.com';
  final tRequest = ForgetPasswordRequestModel(email: tEmail);

  test('should call forgetPassword on the repository', () async {
    // arrange
    when(
      mockRepository.forgetPassword(any),
    ).thenAnswer((_) async => const BaseResponse<void>.success(null));

    // act
    final result = await useCase(tRequest);

    // assert
    expect(result, const BaseResponse<void>.success(null));
    verify(mockRepository.forgetPassword(tRequest));
    verifyNoMoreInteractions(mockRepository);
  });
}
