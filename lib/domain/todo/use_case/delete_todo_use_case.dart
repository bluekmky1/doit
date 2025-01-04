import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';

final AutoDisposeProvider<DeleteTodoUseCase> deleteTodoUseCaseProvider =
    Provider.autoDispose<DeleteTodoUseCase>(
  (Ref<DeleteTodoUseCase> ref) => DeleteTodoUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class DeleteTodoUseCase {
  final TodoRepository _todoRepository;
  DeleteTodoUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<void>> call({
    required String todoId,
  }) async {
    final RepositoryResult<void> result = await _todoRepository.deleteTodo(
      todoId: todoId,
    );
    return switch (result) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
          data: null,
        ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: result.messages?[0],
        )
    };
  }
}
