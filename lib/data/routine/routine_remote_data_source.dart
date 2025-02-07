import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/routine_entity.dart';
import 'request_body/add_routine_request_body.dart';

final Provider<RoutineRemoteDataSource> routineRemoteDataSourceProvider =
    Provider<RoutineRemoteDataSource>(
  (Ref<RoutineRemoteDataSource> ref) =>
      RoutineRemoteDataSource(ref.read(supabaseServiceProvider)),
);

class RoutineRemoteDataSource {
  final SupabaseClient _supabaseClient;

  RoutineRemoteDataSource(this._supabaseClient);

  // 할일 추가
  Future<RoutineEntity> addRoutine({
    required AddRoutineRequestBody body,
  }) async {
    final PostgrestMap response = await _supabaseClient
        .from('routine')
        .insert(body.toJson())
        .select()
        .single();

    return RoutineEntity.fromJson(response);
  }

  // 루틴 활성화 업데이트
  Future<RoutineEntity> updateRoutineActive({
    required String routineId,
    required bool isActive,
  }) async {
    final PostgrestMap response = await _supabaseClient
        .from('routine')
        .update(<String, bool>{'is_active': isActive})
        .eq('routine_id', routineId)
        .select()
        .single();

    return RoutineEntity.fromJson(response);
  }

  // 루틴 삭제
  Future<void> deleteRoutine({
    required String routineId,
  }) async {
    await _supabaseClient.from('routine').delete().eq('routine_id', routineId);
  }

  // 모든 루틴 목록 조회
  Future<List<RoutineEntity>> getRoutineList({
    required String userId,
  }) async {
    final PostgrestList routineList = await _supabaseClient
        .from('routine')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: true);

    return routineList.map(RoutineEntity.fromJson).toList();
  }

  // 활성화된 루틴 목록 조회
  Future<List<RoutineEntity>> getActiveRoutineList({
    required String userId,
  }) async {
    final PostgrestList routineList = await _supabaseClient
        .from('routine')
        .select()
        .eq('user_id', userId)
        .eq('is_active', true)
        .order('created_at', ascending: true);
    return routineList.map(RoutineEntity.fromJson).toList();
  }
}
