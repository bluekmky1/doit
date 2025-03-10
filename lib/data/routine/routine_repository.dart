import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';

import '../../core/common/repository/repository_result.dart';
import 'entity/routine_entity.dart';
import 'request_body/add_routine_request_body.dart';
import 'routine_remote_data_source.dart';

final Provider<RoutineRepository> routineRepositoryProvider =
    Provider<RoutineRepository>(
  (Ref<RoutineRepository> ref) =>
      RoutineRepository(ref.watch(routineRemoteDataSourceProvider)),
);

class RoutineRepository extends Repository {
  const RoutineRepository(this._routineRemoteDataSource);

  final RoutineRemoteDataSource _routineRemoteDataSource;

  // 루틴 추가
  Future<RepositoryResult<RoutineEntity>> addRoutine({
    required String userId,
    required String routineTitle,
  }) async {
    try {
      return SuccessRepositoryResult<RoutineEntity>(
        data: await _routineRemoteDataSource.addRoutine(
          body: AddRoutineRequestBody(
            userId: userId,
            routineTitle: routineTitle,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<RoutineEntity>(
        error: e,
        messages: <String>['데이터를 저장하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<RoutineEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<RoutineEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 루틴 삭제
  Future<RepositoryResult<void>> deleteRoutine({
    required String routineId,
  }) async {
    try {
      await _routineRemoteDataSource.deleteRoutine(
        routineId: routineId,
      );

      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['데이터를 삭제하는 과정에 오류가 있습니다: ${e.message}'],
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

  // 루틴 활성화 여부 수정
  Future<RepositoryResult<RoutineEntity>> updateRoutineActive({
    required String routineId,
    required bool isActive,
  }) async {
    try {
      return SuccessRepositoryResult<RoutineEntity>(
        data: await _routineRemoteDataSource.updateRoutineActive(
          routineId: routineId,
          isActive: isActive,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<RoutineEntity>(
        error: e,
        messages: <String>['데이터를 수정하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<RoutineEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<RoutineEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 모든 루틴 조회
  Future<RepositoryResult<List<RoutineEntity>>> getRoutineList({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult<List<RoutineEntity>>(
        data: await _routineRemoteDataSource.getRoutineList(
          userId: userId,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<RoutineEntity>>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<RoutineEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<RoutineEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 활성화된 루틴 목록 조회
  Future<RepositoryResult<List<RoutineEntity>>> getActiveRoutineList({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult<List<RoutineEntity>>(
        data: await _routineRemoteDataSource.getActiveRoutineList(
          userId: userId,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<RoutineEntity>>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<RoutineEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<RoutineEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }
}
