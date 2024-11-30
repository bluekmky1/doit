import 'package:equatable/equatable.dart';
import '../common/consts/fortune_category.dart';

class FortuneState extends Equatable {
  final FortuneCategory selectedFortuneCategory;

  const FortuneState({
    required this.selectedFortuneCategory,
  });

  const FortuneState.init() : selectedFortuneCategory = FortuneCategory.total;

  FortuneState copyWith({
    FortuneCategory? selectedFortuneCategory,
  }) =>
      FortuneState(
        selectedFortuneCategory:
            selectedFortuneCategory ?? this.selectedFortuneCategory,
      );

  @override
  List<Object> get props => <Object>[
        selectedFortuneCategory,
      ];
}
