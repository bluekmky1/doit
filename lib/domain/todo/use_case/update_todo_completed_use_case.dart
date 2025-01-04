import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/entity/todo_entity.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/todo_model.dart';

final AutoDisposeProvider<UpdateTodoCompletedUseCase>
    updateTodoCompletedUseCaseProvider =
    Provider.autoDispose<UpdateTodoCompletedUseCase>(
  (Ref<UpdateTodoCompletedUseCase> ref) => UpdateTodoCompletedUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class UpdateTodoCompletedUseCase {
  final TodoRepository _todoRepository;
  UpdateTodoCompletedUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<TodoModel>> call({
    required String todoId,
    required bool completed,
    required DateTime completedAt,
  }) async {
    final RepositoryResult<TodoEntity> result =
        await _todoRepository.updateTodoCompleted(
      todoId: todoId,
      completed: completed,
      completedAt: completedAt,
    );
    return switch (result) {
      SuccessRepositoryResult<TodoEntity>() => SuccessUseCaseResult<TodoModel>(
          data: TodoModel.fromEntity(entity: result.data),
        ),
      FailureRepositoryResult<TodoEntity>() => FailureUseCaseResult<TodoModel>(
          message: result.messages?[0],
        )
    };
  }
}
