import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/fortune_entity.dart';
import 'request_body/create_fortune_request_body.dart';

final Provider<FortuneRemoteDataSource> fortuneRemoteDataSourceProvider =
    Provider<FortuneRemoteDataSource>(
  (Ref<FortuneRemoteDataSource> ref) =>
      FortuneRemoteDataSource(ref.read(supabaseServiceProvider)),
);

class FortuneRemoteDataSource {
  final SupabaseClient _supabaseClient;

  FortuneRemoteDataSource(this._supabaseClient);

  // 운세 받아오기
  Future<FortuneResponseEntity> getFortune({
    required String userId,
  }) async {
    final PostgrestMap response = await _supabaseClient
        .from('fortunes')
        .select()
        .eq('user_id', userId)
        .single();

    return FortuneResponseEntity.fromJson(response);
  }

  // 운세 생성
  Future<FortuneResponseEntity> createFortune({
    required CreateFortuneRequestBody body,
  }) async {
    final FunctionResponse response = await _supabaseClient.functions.invoke(
      'gpt',
      body: body.toJson(),
    );

    return FortuneResponseEntity.fromJson(response.data);
  }
}
