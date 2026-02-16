import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repository/forget_password_repository.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/verify_code_use_case.dart';

import 'verify_code_use_case_test.mocks.dart';

@GenerateMocks([ForgetPasswordRepository])
void main() {
  late VerifyCodeUseCase useCase;
  late MockForgetPasswordRepository mockRepository;

  setUp(() {
    mockRepository = MockForgetPasswordRepository();
    useCase = VerifyCodeUseCase(mockRepository);
  });

  const tCode = '123456';
  final tRequest = VerifyCodeRequestModel(tCode);

  test('should call verifyCode on the repository', () async {
    // arrange
    when(
      mockRepository.verifyCode(any),
    ).thenAnswer((_) async => const BaseResponse<void>.success(null));

    // act
    final result = await useCase(tRequest);

    // assert
    expect(result, const BaseResponse<void>.success(null));
    verify(mockRepository.verifyCode(tRequest));
    verifyNoMoreInteractions(mockRepository);
  });
}
