import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';

class FarmState extends Equatable {
  final LoadingStatus getGoalLoadingStatus;

  final bool isAnimalButtonSelected;
  final bool isClockButtonSelected;

  const FarmState({
    required this.getGoalLoadingStatus,
    required this.isAnimalButtonSelected,
    required this.isClockButtonSelected,
  });

  const FarmState.init()
      : getGoalLoadingStatus = LoadingStatus.none,
        isAnimalButtonSelected = false,
        isClockButtonSelected = true;

  FarmState copyWith({
    LoadingStatus? getGoalLoadingStatus,
    bool? isAnimalButtonSelected,
    bool? isClockButtonSelected,
  }) =>
      FarmState(
        getGoalLoadingStatus: getGoalLoadingStatus ?? this.getGoalLoadingStatus,
        isAnimalButtonSelected:
            isAnimalButtonSelected ?? this.isAnimalButtonSelected,
        isClockButtonSelected:
            isClockButtonSelected ?? this.isClockButtonSelected,
      );

  @override
  List<Object> get props => <Object>[
        getGoalLoadingStatus,
        isAnimalButtonSelected,
        isClockButtonSelected,
      ];
}
