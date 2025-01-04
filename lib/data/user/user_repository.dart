import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';
import '../../core/common/repository/repository_result.dart';
import '../../domain/user/model/user_data_model.dart';
import 'entity/user_data_entity.dart';
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
        data: UserDataEntity(
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
}
