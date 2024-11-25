import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../model/todo_model.dart';

final AutoDisposeProvider<GetTodoListUseCase> getTodoListUseCaseProvider =
    Provider.autoDispose<GetTodoListUseCase>(
  (Ref<GetTodoListUseCase> ref) => GetTodoListUseCase(
      // exampleRepository: ref.read(exampleRepositoryProvider),
      ),
);

class GetTodoListUseCase {
  // final ExampleRepository _exampleRepository;
  GetTodoListUseCase();
  // ({
  //   required ExampleRepository exampleRepository,
  // }) : _exampleRepository = exampleRepository;

  Future<UseCaseResult<List<TodoModel>>> call() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final RepositoryResult<List<TodoModel>> repositoryResult =
        await Future<RepositoryResult<List<TodoModel>>>.value(
      SuccessRepositoryResult<List<TodoModel>>(
        data: <TodoModel>[
          TodoModel(
            id: '1',
            title: '할 일1',
            isDone: false,
            createdAt: DateTime.now(),
          ),
          TodoModel(
            id: '2',
            title: '할 일2',
            isDone: false,
            createdAt: DateTime.now(),
          ),
          TodoModel(
            id: '3',
            title: '할 일3',
            isDone: false,
            createdAt: DateTime.now(),
          ),
        ],
      ),
    );
    //     await _exampleRepository.getExample(
    //         // 기본 9개로 고정
    // title: title);
    return switch (repositoryResult) {
      SuccessRepositoryResult<List<TodoModel>>() =>
        SuccessUseCaseResult<List<TodoModel>>(
          data: repositoryResult.data,
          // 받아오는 데이터가 리스트일 경우
          // ExampleModel.generate(
          //   repositoryResult.data.contents.length,
          //   (int index) => ExampleModel.fromEntity(
          //     entity: repositoryResult.data.contents[index],
          //   ),
          // ),
        ),
      FailureRepositoryResult<List<TodoModel>>() =>
        FailureUseCaseResult<List<TodoModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
