import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/exception/auth_exception.dart';
import 'package:tracking_app/config/services/token_service.dart';
import 'package:tracking_app/features/auth/apply/api/data_sources_impl/local/apply_local_data_source_impl.dart';
import 'package:tracking_app/features/auth/apply/data/datasources/local/apply_local_data_source.dart';

import 'apply_local_data_source_impl_test.mocks.dart';

@GenerateMocks([TokenService])
void main() {
  late MockTokenService mockTokenService;
  late ApplyLocalDataSource applyLocalDataSource;
  setUp(() {
    mockTokenService = MockTokenService();
    applyLocalDataSource = ApplyLocalDataSourceImpl(mockTokenService);
  });
  group('apply local data source impl', () {
    test('success case', () async {
      when(
        mockTokenService.saveToken(any),
      ).thenAnswer((_) async => const BaseResponse.success(true));
      final response = await applyLocalDataSource.saveToken('token');
      expect(response, isA<Success>());
    });
    test('failure case', () async {
      when(mockTokenService.saveToken(any)).thenAnswer(
        (_) async => BaseResponse.failure(AuthException(message: 'error')),
      );
      final response = await applyLocalDataSource.saveToken('token');
      expect(response, isA<Failure>());
      response as Failure;
      expect(response.exception.message, 'error');
    });
  });
}
