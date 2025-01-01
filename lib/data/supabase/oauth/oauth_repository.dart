// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import '../../../core/common/repository/repository.dart';
// import '../../../core/common/repository/repository_result.dart';
// import 'entity/supabase_entity.dart';
// import 'oauth_remote_data_source.dart';

// final Provider<SupabaseRepository> supabaseRepositoryProvider =
//     Provider<SupabaseRepository>(
//   (Ref<SupabaseRepository> ref) =>
//       SupabaseRepository(ref.watch(supabaseRemoteDataSourceProvider)),
// );

// class SupabaseRepository extends Repository {
//   const SupabaseRepository(this._supabaseRemoteDataSource);

//   final SupabaseRemoteDataSource _supabaseRemoteDataSource;

//   Future<RepositoryResult<List<SupabaseEntity>>> getItems({
//     required String tableName,
//     String? searchQuery,
//   }) async {
//     try {
//       return SuccessRepositoryResult<List<SupabaseEntity>>(
//         data: await _supabaseRemoteDataSource.getItems(
//           tableName: tableName,
//           searchQuery: searchQuery,
//         ),
//       );
//     } on PostgrestException catch (e) {
//       return FailureRepositoryResult<List<SupabaseEntity>>(
//         error: e,
//         messages: <String>['데이터를 불러오는 과정에 오류가 있습니다: ${e.message}'],
//       );
//     } on AuthException catch (e) {
//       return FailureRepositoryResult<List<SupabaseEntity>>(
//         error: e,
//         messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
//       );
//     } on Exception catch (e) {
//       return FailureRepositoryResult<List<SupabaseEntity>>(
//         error: e,
//         messages: <String>['예상치 못한 오류가 발생했습니다'],
//       );
//     }
//   }

//   Future<RepositoryResult<SupabaseEntity>> insertItem({
//     required String tableName,
//     required Map<String, dynamic> data,
//   }) async {
//     try {
//       return SuccessRepositoryResult<SupabaseEntity>(
//         data: await _supabaseRemoteDataSource.insertItem(
//           tableName: tableName,
//           data: data,
//         ),
//       );
//     } on PostgrestException catch (e) {
//       return FailureRepositoryResult<SupabaseEntity>(
//         error: e,
//         messages: <String>['데이터 추가 중 오류가 발생했습니다: ${e.message}'],
//       );
//     } on AuthException catch (e) {
//       return FailureRepositoryResult<SupabaseEntity>(
//         error: e,
//         messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
//       );
//     } on Exception catch (e) {
//       return FailureRepositoryResult<SupabaseEntity>(
//         error: e,
//         messages: <String>['예상치 못한 오류가 발생했습니다'],
//       );
//     }
//   }
// }
