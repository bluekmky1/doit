import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/todo/entity/todo_entity.dart';
import '../../../data/todo/todo_repository.dart';
import '../model/todo_model.dart';

final AutoDisposeProvider<AddTodoByRecommendUseCase>
    addTodoByRecommendUseCaseProvider =
    Provider.autoDispose<AddTodoByRecommendUseCase>(
  (Ref<AddTodoByRecommendUseCase> ref) => AddTodoByRecommendUseCase(
    todoRepository: ref.read(todoRepositoryProvider),
  ),
);

class AddTodoByRecommendUseCase {
  final TodoRepository _todoRepository;
  AddTodoByRecommendUseCase({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository;

  Future<UseCaseResult<TodoModel>> call({
    required String userId,
    required String title,
    required DateTime dueDate,
    required String recommendId,
  }) async {
    final RepositoryResult<TodoEntity> result =
        await _todoRepository.addRecommendTodoToTodoList(
      userId: userId,
      title: title,
      dueDate: dueDate,
      recommendId: recommendId,
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
