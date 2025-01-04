import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import '../../domain/user/model/user_data_model.dart';
import 'entity/user_data_entity.dart';
import 'request_body/post_user_data_request_body.dart';
import 'request_body/update_user_data_request_body.dart';
import 'user_remote_data_source.dart';

final Provider<UserRepository> userRepositoryProvider =
    Provider<UserRepository>(
  (Ref<UserRepository> ref) =>
      UserRepository(ref.watch(userRemoteDataSourceProvider)),
);

class UserRepository extends Repository {
  const UserRepository(this._userRemoteDataSource);

  final UserRemoteDataSource _userRemoteDataSource;

  Future<RepositoryResult<void>> postUserData({
    required UserDataModel data,
  }) async {
    try {
      await _userRemoteDataSource.postUserData(
        data: PostUserDataRequestBody(
          userId: data.id,
          nickname: data.nickname,
          gender: data.gender,
          lunarSolar: data.lunarSolar,
          birthDate: data.birthDate,
          consent: data.consent,
          unknownBirthTime: data.unknownBirthTime,
        ),
      );

      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['데이터를 저장하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<UserDataEntity>> getUserData({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult<UserDataEntity>(
        data: await _userRemoteDataSource.getUserData(
          userId: userId,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<UserDataEntity>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<UserDataEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<UserDataEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  Future<RepositoryResult<void>> updateUserData({
    required UserDataModel data,
  }) async {
    try {
      await _userRemoteDataSource.updateUserData(
        userId: data.id,
        data: UpdateUserDataRequestBody(
          userId: data.id,
          nickname: data.nickname,
          gender: data.gender,
          lunarSolar: data.lunarSolar,
          birthDate: data.birthDate,
          consent: data.consent,
          unknownBirthTime: data.unknownBirthTime,
        ),
      );

      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['데이터를 수정하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
