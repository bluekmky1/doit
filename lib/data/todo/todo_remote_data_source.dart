import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../service/supabase/supabase_service.dart';
import 'entity/todo_entity.dart';
import 'request_body/add_todo_request_body.dart';
import 'request_body/add_todo_with_routine_request_body.dart';
import 'request_body/update_todo_completed_request_body.dart';
import 'request_body/update_todo_request_body.dart';

final Provider<TodoRemoteDataSource> todoRemoteDataSourceProvider =
    Provider<TodoRemoteDataSource>(
  (Ref<TodoRemoteDataSource> ref) =>
      TodoRemoteDataSource(ref.read(supabaseServiceProvider)),
);

class TodoRemoteDataSource {
  final SupabaseClient _supabaseClient;

  TodoRemoteDataSource(this._supabaseClient);

  // 할일 추가
  Future<TodoEntity> addTodo({
    required AddTodoRequestBody body,
  }) async {
    final PostgrestMap response =
        await _supabaseClient.from('todo').insert(body.toJson()).select('''
          *,
          animal:animal_id(
            name            
          )
          ''').single();

    return TodoEntity.fromJson(response);
  }

  // 루틴으로 할 일 추가
  Future<TodoEntity> addTodoWithRoutine({
    required AddTodoWithRoutineRequestBody body,
  }) async {
    final PostgrestMap response =
        await _supabaseClient.from('todo').insert(body.toJson()).select('''
          *,
          animal:animal_id(
            name            
          )
          ''').single();

    return TodoEntity.fromJson(response);
  }

  // 할일 완료 업데이트
  Future<TodoEntity> updateTodoCompleted({
    required String todoId,
    required UpdateTodoCompletedRequestBody body,
  }) async {
    final PostgrestMap response = await _supabaseClient
        .from('todo')
        .update(body.toJson())
        .eq('todo_id', todoId)
        .select('''
          *,
          animal:animal_id(
            name            
          )
          ''').single();

    return TodoEntity.fromJson(response);
  }

  // 할일 수정
  Future<void> updateTodo({
    required String todoId,
    required UpdateTodoRequestBody body,
  }) async {
    await _supabaseClient
        .from('todo')
        .update(body.toJson())
        .eq('todo_id', todoId);
  }

  // 할일 삭제
  Future<void> deleteTodo({
    required String todoId,
  }) async {
    await _supabaseClient.from('todo').delete().eq('todo_id', todoId);
  }

  // 특정 날짜의 할일 목록 조회
  Future<List<TodoEntity>> getTodoListWithDate({
    required String userId,
    required DateTime dueDate,
  }) async {
    final PostgrestList todoList = await _supabaseClient.from('todo').select('''
          *,
          animal:animal_id(
            name            
          )
          ''').eq('user_id', userId).eq('due_date', dueDate);

    return todoList.map(TodoEntity.fromJson).toList();
  }

  // 기간 내 할일 목록 조회
  Future<List<TodoEntity>> getTodoListWithPeriod({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final PostgrestList todoList = await _supabaseClient
        .from('todo')
        .select('''
          *,
          animal:animal_id(            
            name            
          )
          ''')
        .eq('user_id', userId)
        .gte('due_date', startDate)
        .lte('due_date', endDate);

    return todoList.map(TodoEntity.fromJson).toList();
  }

  // 모든 할일 목록 조회
  Future<List<TodoEntity>> getTodoList({
    required String userId,
  }) async {
    final PostgrestList todoList = await _supabaseClient.from('todo').select('''
          *,
          animal:animal_id(            
            name            
          )
          ''').eq('user_id', userId);
    return todoList.map(TodoEntity.fromJson).toList();
  }
}
