import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/todo_repository.dart';

final AutoDisposeProvider<DeleteRecommendTodoFromTodoListUseCase>
    deleteRecommendTodoFromTodoListUseCaseProvider =
    Provider.autoDispose<DeleteRecommendTodoFromTodoListUseCase>(
  (Ref<DeleteRecommendTodoFromTodoListUseCase> ref) =>
      DeleteRecommendTodoFromTodoListUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class DeleteRecommendTodoFromTodoListUseCase {
  final TodoRepository _todoRepository;
  DeleteRecommendTodoFromTodoListUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<void>> call({
    required String recommendId,
  }) async {
    final RepositoryResult<void> result =
        await _todoRepository.deleteRecommendTodoFromTodoList(
      recommendId: recommendId,
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
