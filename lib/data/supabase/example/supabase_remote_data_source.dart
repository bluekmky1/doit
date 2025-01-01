import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../service/supabase_service.dart';
import 'entity/supabase_entity.dart';

final Provider<SupabaseRemoteDataSource> supabaseRemoteDataSourceProvider =
    Provider<SupabaseRemoteDataSource>(
  (Ref<SupabaseRemoteDataSource> ref) =>
      SupabaseRemoteDataSource(ref.read(supabaseServiceProvider)),
);

class SupabaseRemoteDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseRemoteDataSource(this._supabaseClient);

  Future<List<SupabaseEntity>> getItems({
    required String tableName,
    String? searchQuery,
  }) async {
    final PostgrestList response = await _supabaseClient
        .from(tableName)
        .select()
        .ilike('title', '%$searchQuery%');

    return response.map(SupabaseEntity.fromJson).toList();
  }

  Future<SupabaseEntity> insertItem({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    final PostgrestMap response =
        await _supabaseClient.from(tableName).insert(data).single();

    return SupabaseEntity.fromJson(response);
  }
}
