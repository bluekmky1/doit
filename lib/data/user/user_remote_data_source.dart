import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/user_data_entity.dart';
import 'request_body/post_user_data_request_body.dart';
import 'request_body/update_user_data_request_body.dart';

final Provider<UserRemoteDataSource> userRemoteDataSourceProvider =
    Provider<UserRemoteDataSource>(
  (Ref<UserRemoteDataSource> ref) =>
      UserRemoteDataSource(ref.read(supabaseServiceProvider)),
);

class UserRemoteDataSource {
  final SupabaseClient _supabaseClient;

  UserRemoteDataSource(this._supabaseClient);

  Future<void> postUserData({
    required PostUserDataRequestBody data,
  }) async {
    await _supabaseClient.from('user').insert(data.toJson());
  }

  Future<UserDataEntity> getUserData({
    required String userId,
  }) async {
    final PostgrestMap userData = await _supabaseClient
        .from('user')
        .select()
        .eq('user_id', userId)
        .single();
    return UserDataEntity.fromJson(userData);
  }

  Future<void> updateUserData({
    required String userId,
    required UpdateUserDataRequestBody data,
  }) async {
    await _supabaseClient
        .from('user')
        .update(data.toJson())
        .eq('user_id', userId);
  }
}
