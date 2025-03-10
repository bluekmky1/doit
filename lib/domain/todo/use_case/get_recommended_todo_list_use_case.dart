import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/entity/recommend_todo_entity.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/recommended_todo_model.dart';

final AutoDisposeProvider<GetRecommendedTodoListUseCase>
    getRecommendedTodoListUseCaseProvider =
    Provider.autoDispose<GetRecommendedTodoListUseCase>(
  (Ref<GetRecommendedTodoListUseCase> ref) => GetRecommendedTodoListUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class GetRecommendedTodoListUseCase {
  final TodoRepository _todoRepository;
  GetRecommendedTodoListUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<List<RecommendedTodoModel>>> call({
    required String userId,
  }) async {
    final RepositoryResult<List<RecommendTodoEntity>> repositoryResult =
        await _todoRepository.getRecommendTodoList(
      userId: userId,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<List<RecommendTodoEntity>>() =>
        SuccessUseCaseResult<List<RecommendedTodoModel>>(
          data: List<RecommendedTodoModel>.generate(
            repositoryResult.data.length,
            (int index) => RecommendedTodoModel.fromEntity(
              entity: repositoryResult.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<RecommendTodoEntity>>() =>
        FailureUseCaseResult<List<RecommendedTodoModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
