import 'package:equatable/equatable.dart';

import '../../../data/fortune/entity/fortune_entity.dart';
import '../../../ui/common/consts/fortune_category.dart';

class FortuneDetailModel extends Equatable {
  final FortuneCategory category;
  final String content;
  final int score;

  const FortuneDetailModel({
    required this.category,
    required this.content,
    required this.score,
  });

  factory FortuneDetailModel.fromEntity({
    required FortuneDetailEntity entity,
  }) =>
      FortuneDetailModel(
        category: FortuneCategory.fromString(entity.category),
        content: entity.content,
        score: entity.score,
      );

  @override
  List<Object?> get props => <Object?>[
        category,
        content,
        score,
      ];
}
