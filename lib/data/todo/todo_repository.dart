import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/repository/repository.dart';

import '../../core/common/repository/repository_result.dart';
import 'entity/recommend_todo_entity.dart';
import 'entity/todo_entity.dart';
import 'request_body/add_todo_by_recommend_reqest_body.dart';
import 'request_body/add_todo_request_body.dart';
import 'request_body/add_todo_with_routine_request_body.dart';
import 'request_body/update_todo_completed_request_body.dart';
import 'request_body/update_todo_request_body.dart';
import 'todo_remote_data_source.dart';

final Provider<TodoRepository> todoRepositoryProvider =
    Provider<TodoRepository>(
  (Ref<TodoRepository> ref) =>
      TodoRepository(ref.watch(todoRemoteDataSourceProvider)),
);

class TodoRepository extends Repository {
  const TodoRepository(this._todoRemoteDataSource);

  final TodoRemoteDataSource _todoRemoteDataSource;

  // 할일 추가
  Future<RepositoryResult<TodoEntity>> addTodo({
    required String userId,
    required String title,
    required DateTime dueDate,
  }) async {
    try {
      return SuccessRepositoryResult<TodoEntity>(
        data: await _todoRemoteDataSource.addTodo(
          body: AddTodoRequestBody(
            userId: userId,
            title: title,
            dueDate: dueDate,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['데이터를 저장하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 루틴으로 할일 추가
  Future<RepositoryResult<TodoEntity>> addTodoWithRoutine({
    required String routineId,
    required String userId,
    required String title,
    required DateTime dueDate,
  }) async {
    try {
      return SuccessRepositoryResult<TodoEntity>(
        data: await _todoRemoteDataSource.addTodoWithRoutine(
          body: AddTodoWithRoutineRequestBody(
            routineId: routineId,
            userId: userId,
            title: title,
            dueDate: dueDate,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['데이터를 저장하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 할일 수정
  Future<RepositoryResult<void>> updateTodo({
    required String todoId,
    required String title,
  }) async {
    try {
      await _todoRemoteDataSource.updateTodo(
        todoId: todoId,
        body: UpdateTodoRequestBody(
          title: title,
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

  // 할일 완료 여부 수정
  Future<RepositoryResult<TodoEntity>> updateTodoCompleted({
    required String todoId,
    required bool completed,
    required DateTime completedAt,
  }) async {
    try {
      return SuccessRepositoryResult<TodoEntity>(
        data: await _todoRemoteDataSource.updateTodoCompleted(
          todoId: todoId,
          body: UpdateTodoCompletedRequestBody(
            isCompleted: completed,
            completedAt: completedAt,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['데이터를 수정하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 할일 삭제
  Future<RepositoryResult<void>> deleteTodo({
    required String todoId,
  }) async {
    try {
      await _todoRemoteDataSource.deleteTodo(
        todoId: todoId,
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

  // 특정 날짜의 할일 목록 조회
  Future<RepositoryResult<List<TodoEntity>>> getTodoListWithDate({
    required String userId,
    required DateTime dueDate,
  }) async {
    try {
      return SuccessRepositoryResult<List<TodoEntity>>(
        data: await _todoRemoteDataSource.getTodoListWithDate(
          userId: userId,
          dueDate: dueDate,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 모든 할일 목록 조회
  Future<RepositoryResult<List<TodoEntity>>> getTodoList({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult<List<TodoEntity>>(
        data: await _todoRemoteDataSource.getTodoList(
          userId: userId,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 기간 내 할일 목록 조회
  Future<RepositoryResult<List<TodoEntity>>> getTodoListWithPeriod({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      return SuccessRepositoryResult<List<TodoEntity>>(
        data: await _todoRemoteDataSource.getTodoListWithPeriod(
          userId: userId,
          startDate: startDate,
          endDate: endDate,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<TodoEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 추천 할일 목록 조회
  Future<RepositoryResult<List<RecommendTodoEntity>>> getRecommendTodoList({
    required String userId,
  }) async {
    try {
      return SuccessRepositoryResult<List<RecommendTodoEntity>>(
        data: await _todoRemoteDataSource.getRecommendTodoList(
          userId: userId,
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<List<RecommendTodoEntity>>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<List<RecommendTodoEntity>>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<List<RecommendTodoEntity>>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 추천 할일 추가
  Future<RepositoryResult<TodoEntity>> addRecommendTodoToTodoList({
    required String userId,
    required String title,
    required String recommendId,
    required DateTime dueDate,
  }) async {
    try {
      return SuccessRepositoryResult<TodoEntity>(
        data: await _todoRemoteDataSource.addRecommendTodoToTodoList(
          body: AddTodoByRecommendRequestBody(
            userId: userId,
            title: title,
            recommendId: recommendId,
            dueDate: dueDate,
          ),
        ),
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
      );
    } on AuthException catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['인증 오류가 발생했습니다: ${e.message}'],
      );
    } on Exception catch (e) {
      return FailureRepositoryResult<TodoEntity>(
        error: e,
        messages: <String>['예상치 못한 오류가 발생했습니다'],
      );
    }
  }

  // 추천 할일 삭제
  Future<RepositoryResult<void>> deleteRecommendTodoFromTodoList({
    required String recommendId,
  }) async {
    try {
      await _todoRemoteDataSource.deleteRecommendTodoFromTodoList(
        recommendId: recommendId,
      );

      return const SuccessRepositoryResult<void>(
        data: null,
      );
    } on PostgrestException catch (e) {
      return FailureRepositoryResult<void>(
        error: e,
        messages: <String>['데이터를 조회하는 과정에 오류가 있습니다: ${e.message}'],
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
