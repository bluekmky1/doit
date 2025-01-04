import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/user_data_entity.dart';

final Provider<UserRemoteDataSource> userRemoteDataSourceProvider =
    Provider<UserRemoteDataSource>(
  (Ref<UserRemoteDataSource> ref) =>
      UserRemoteDataSource(ref.read(supabaseServiceProvider)),
);

class UserRemoteDataSource {
  final SupabaseClient _supabaseClient;

  UserRemoteDataSource(this._supabaseClient);

  Future<void> postUserData({
    required UserDataEntity data,
  }) async {
    await _supabaseClient.from('user').insert(data.toJson());
  }

  Future<PostgrestMap> getUserData({
    required String userId,
  }) async {
    final PostgrestMap userData = await _supabaseClient
        .from('user')
        .select()
        .eq('user_id', userId)
        .single();
    return userData;
  }
}
