import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';

import '../../core/common/repository/repository_result.dart';
import 'entity/fortune_entity.dart';
import 'fortune_remote_data_source.dart';
import 'request_body/create_fortune_request_body.dart';

final Provider<FortuneRepository> fortuneRepositoryProvider =
    Provider<FortuneRepository>(
  (Ref<FortuneRepository> ref) =>
      FortuneRepository(ref.watch(fortuneRemoteDataSourceProvider)),
);

class FortuneRepository extends Repository {
  const FortuneRepository(this._fortuneRemoteDataSource);

  final FortuneRemoteDataSource _fortuneRemoteDataSource;

  // 운세 생성
  Future<RepositoryResult<FortuneResponseEntity>> createFortune({
    required String userId,
    required String birthDate,
    required String birthTime,
    required String gender,
  }) async {
    try {
      return SuccessRepositoryResult<FortuneResponseEntity>(
        data: await _fortuneRemoteDataSource.createFortune(
          body: CreateFortuneRequestBody(
            userId: userId,
            birthDate: birthDate,
            birthTime: birthTime,
            gender: gender,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<FortuneResponseEntity>(
        error: e,
        messages: <String>['데이터를 생성하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<FortuneResponseEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<FortuneResponseEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 운세 조회
  Future<RepositoryResult<FortuneResponseEntity>> getFortune({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult<FortuneResponseEntity>(
        data: await _fortuneRemoteDataSource.getFortune(
          userId: userId,
        ),
      );
    } on PostgrestException catch (e) {
      print(e);
      return FailureRepositoryResult<FortuneResponseEntity>(
        messages: <String>['데이터를 조회하는  과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<FortuneResponseEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<FortuneResponseEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
