import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../model/recommended_todo_model.dart';

final AutoDisposeProvider<GetRecommendedTodoListUseCase>
    getRecommendedTodoListUseCaseProvider =
    Provider.autoDispose<GetRecommendedTodoListUseCase>(
  (Ref<GetRecommendedTodoListUseCase> ref) => GetRecommendedTodoListUseCase(
      // exampleRepository: ref.read(exampleRepositoryProvider),
      ),
);

class GetRecommendedTodoListUseCase {
  // final TodoListRepository _exampleRepository;
  GetRecommendedTodoListUseCase();
  // ({
  // required TodoListRepository exampleRepository,
  // });
  // : _exampleRepository = exampleRepository;

  Future<UseCaseResult<List<RecommendedTodoModel>>> call() async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final RepositoryResult<List<RecommendedTodoModel>> repositoryResult =
        await Future<RepositoryResult<List<RecommendedTodoModel>>>.value(
      SuccessRepositoryResult<List<RecommendedTodoModel>>(
        data: <RecommendedTodoModel>[
          RecommendedTodoModel(
            id: '1',
            title: '추천 할 일1',
            fortune: '연애운',
            isDone: false,
            createdAt: DateTime.now(),
          ),
          RecommendedTodoModel(
            id: '2',
            title: '추천 할 일2',
            fortune: '금전운',
            isDone: false,
            createdAt: DateTime.now(),
          ),
          RecommendedTodoModel(
            id: '3',
            title: '추천 할 일3',
            fortune: '학업운',
            isDone: false,
            createdAt: DateTime.now(),
          ),
        ],
      ),
    );
    //     await _exampleRepository.getTodoList(
    //         // 기본 9개로 고정
    //         title: title);
    return switch (repositoryResult) {
      SuccessRepositoryResult<List<RecommendedTodoModel>>() =>
        SuccessUseCaseResult<List<RecommendedTodoModel>>(
          data: repositoryResult.data,
        ),
      FailureRepositoryResult<List<RecommendedTodoModel>>() =>
        FailureUseCaseResult<List<RecommendedTodoModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
