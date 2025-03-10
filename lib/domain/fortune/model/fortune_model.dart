import 'package:equatable/equatable.dart';

import '../../../data/fortune/entity/fortune_entity.dart';
import 'fortune_detail_model.dart';

class FortuneModel extends Equatable {
  final String summary;
  final List<FortuneDetailModel> details;
  final DateTime createdAt;

  const FortuneModel({
    required this.summary,
    required this.details,
    required this.createdAt,
  });

  factory FortuneModel.fromEntity({
    required FortuneResponseEntity entity,
  }) =>
      FortuneModel(
        summary: entity.fortune.summary,
        details: List<FortuneDetailModel>.generate(
          entity.fortune.details.length,
          (int index) => FortuneDetailModel.fromEntity(
            entity: entity.fortune.details[index],
          ),
        ),
        createdAt: entity.createdAt,
      );

  @override
  List<Object?> get props => <Object?>[
        summary,
        details,
        createdAt,
      ];
}
