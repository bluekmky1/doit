import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/user/entity/user_data_entity.dart';
import '../../../data/user/user_repository.dart';
import '../model/user_data_model.dart';

final AutoDisposeProvider<GetUserDataUseCase> getUserDataUseCaseProvider =
    Provider.autoDispose<GetUserDataUseCase>(
  (Ref<GetUserDataUseCase> ref) => GetUserDataUseCase(
    userRepository: ref.read(userRepositoryProvider),
  ),
);

class GetUserDataUseCase {
  final UserRepository _userRepository;
  GetUserDataUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<UseCaseResult<UserDataModel>> call({
    required String userId,
  }) async {
    final RepositoryResult<UserDataEntity> result =
        await _userRepository.getUserData(
      userId: userId,
    );

    return switch (result) {
      SuccessRepositoryResult<UserDataEntity>() =>
        SuccessUseCaseResult<UserDataModel>(
          data: UserDataModel.fromEntity(result.data),
        ),
      FailureRepositoryResult<UserDataEntity>() =>
        FailureUseCaseResult<UserDataModel>(
          message: result.messages?[0],
        )
    };
  }
}
