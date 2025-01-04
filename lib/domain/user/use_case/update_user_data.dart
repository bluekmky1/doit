import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/user/user_repository.dart';
import '../model/user_data_model.dart';

final AutoDisposeProvider<UpdateUserDataUseCase> updateUserDataUseCaseProvider =
    Provider.autoDispose<UpdateUserDataUseCase>(
  (Ref<UpdateUserDataUseCase> ref) => UpdateUserDataUseCase(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class UpdateUserDataUseCase {
  final UserRepository _userRepository;
  UpdateUserDataUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<UseCaseResult<void>> call({
    required UserDataModel data,
  }) async {
    final RepositoryResult<void> repositoryResult =
        await _userRepository.updateUserData(
      data: data,
    );

    return switch (repositoryResult) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
          data: null,
        ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
