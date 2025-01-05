import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../common/consts/animal_type.dart';

class FarmState extends Equatable {
  final LoadingStatus getTodoListLoadingStatus;

  final bool isAnimalButtonSelected;
  final bool isClockButtonSelected;

  final int animalCount;
  final List<AnimalMarkerModel> animalList;

  const FarmState({
    required this.getTodoListLoadingStatus,
    required this.isAnimalButtonSelected,
    required this.isClockButtonSelected,
    required this.animalList,
    required this.animalCount,
  });

  FarmState.init()
      : getTodoListLoadingStatus = LoadingStatus.none,
        isAnimalButtonSelected = false,
        isClockButtonSelected = true,
        animalList = List<AnimalMarkerModel>.generate(
          AnimalType.values.length,
          (int index) => AnimalMarkerModel(
            name: AnimalType.values[index].name,
            count: 0,
          ),
        ),
        animalCount = 0;

  FarmState copyWith({
    LoadingStatus? getTodoListLoadingStatus,
    bool? isAnimalButtonSelected,
    bool? isClockButtonSelected,
    List<AnimalMarkerModel>? animalList,
    int? animalCount,
  }) =>
      FarmState(
        getTodoListLoadingStatus:
            getTodoListLoadingStatus ?? this.getTodoListLoadingStatus,
        isAnimalButtonSelected:
            isAnimalButtonSelected ?? this.isAnimalButtonSelected,
        isClockButtonSelected:
            isClockButtonSelected ?? this.isClockButtonSelected,
        animalList: animalList ?? this.animalList,
        animalCount: animalCount ?? this.animalCount,
      );

  @override
  List<Object> get props => <Object>[
        getTodoListLoadingStatus,
        isAnimalButtonSelected,
        isClockButtonSelected,
        animalList,
        animalCount,
      ];
}
