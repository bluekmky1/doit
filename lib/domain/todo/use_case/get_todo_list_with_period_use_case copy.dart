import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/entity/todo_entity.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/todo_model.dart';

final AutoDisposeProvider<GetTodoListWithPeriodUseCase>
    getTodoListWithPeriodUseCaseProvider =
    Provider.autoDispose<GetTodoListWithPeriodUseCase>(
  (Ref<GetTodoListWithPeriodUseCase> ref) => GetTodoListWithPeriodUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class GetTodoListWithPeriodUseCase {
  final TodoRepository _todoRepository;
  GetTodoListWithPeriodUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<List<TodoModel>>> call({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final RepositoryResult<List<TodoEntity>> repositoryResult =
        await _todoRepository.getTodoListWithPeriod(
      userId: userId,
      startDate: startDate,
      endDate: endDate,
    );
    return switch (repositoryResult) {
      SuccessRepositoryResult<List<TodoEntity>>() =>
        SuccessUseCaseResult<List<TodoModel>>(
          data: List<TodoModel>.generate(
            repositoryResult.data.length,
            (int index) => TodoModel.fromEntity(
              entity: repositoryResult.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<TodoEntity>>() =>
        FailureUseCaseResult<List<TodoModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
