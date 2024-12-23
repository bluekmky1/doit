import 'package:equatable/equatable.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../common/consts/fortune_category.dart';

class FortuneState extends Equatable {
  final FortuneCategory selectedFortuneCategory;
  final List<RecommendedTodoModel> recommendedTodoList;

  const FortuneState({
    required this.selectedFortuneCategory,
    required this.recommendedTodoList,
  });

  const FortuneState.init()
      : selectedFortuneCategory = FortuneCategory.total,
        recommendedTodoList = const <RecommendedTodoModel>[];

  FortuneState copyWith({
    FortuneCategory? selectedFortuneCategory,
    List<RecommendedTodoModel>? recommendedTodoList,
  }) =>
      FortuneState(
        selectedFortuneCategory:
            selectedFortuneCategory ?? this.selectedFortuneCategory,
        recommendedTodoList: recommendedTodoList ?? this.recommendedTodoList,
      );

  @override
  List<Object> get props => <Object>[
        selectedFortuneCategory,
        recommendedTodoList,
      ];
}
