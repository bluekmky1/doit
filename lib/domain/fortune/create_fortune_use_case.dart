import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/fortune/fortune_repository.dart';
import '../../data/fortune/entity/fortune_entity.dart';
import 'model/fortune_model.dart';

final AutoDisposeProvider<CreateFortuneUseCase> createFortuneUseCaseProvider =
    Provider.autoDispose<CreateFortuneUseCase>(
  (Ref<CreateFortuneUseCase> ref) => CreateFortuneUseCase(
    fortuneRepository: ref.read(fortuneRepositoryProvider),
  ),
);

class CreateFortuneUseCase {
  final FortuneRepository _fortuneRepository;
  CreateFortuneUseCase({
    required FortuneRepository fortuneRepository,
  }) : _fortuneRepository = fortuneRepository;

  Future<UseCaseResult<FortuneModel>> call({
    required String userId,
    required String birthDate,
    required String birthTime,
    required String gender,
  }) async {
    final RepositoryResult<FortuneResponseEntity> result =
        await _fortuneRepository.createFortune(
      userId: userId,
      birthDate: birthDate,
      birthTime: birthTime,
      gender: gender,
    );
    return switch (result) {
      SuccessRepositoryResult<FortuneResponseEntity>() =>
        SuccessUseCaseResult<FortuneModel>(
          data: FortuneModel.fromEntity(entity: result.data),
        ),
      FailureRepositoryResult<FortuneResponseEntity>() =>
        FailureUseCaseResult<FortuneModel>(
          message: result.messages?[0],
        )
    };
  }
}
