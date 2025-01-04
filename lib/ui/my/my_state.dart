import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../common/consts/animal_type.dart';

class MyState extends Equatable {
  final LoadingStatus getTodoListLoadingStatus;
  final LoadingStatus getUserDataLoadingStatus;

  final String userName;
  final String lunarSolar;
  final DateTime birthDate;
  final String gender;
  final bool unknownBirthTime;

  final int completedTodoCount;
  final List<AnimalMarkerModel> animalMarkerList;

  const MyState({
    required this.getTodoListLoadingStatus,
    required this.getUserDataLoadingStatus,
    required this.userName,
    required this.lunarSolar,
    required this.birthDate,
    required this.gender,
    required this.unknownBirthTime,
    required this.completedTodoCount,
    required this.animalMarkerList,
  });

  MyState.init()
      : getUserDataLoadingStatus = LoadingStatus.none,
        getTodoListLoadingStatus = LoadingStatus.none,
        userName = '',
        lunarSolar = '',
        birthDate = DateTime.now(),
        gender = '',
        unknownBirthTime = false,
        completedTodoCount = 0,
        animalMarkerList = List<AnimalMarkerModel>.generate(
          AnimalType.values.length,
          (int index) => AnimalMarkerModel(
            name: AnimalType.values[index].name,
            count: 0,
          ),
        );

  MyState copyWith({
    LoadingStatus? getUserDataLoadingStatus,
    LoadingStatus? getTodoListLoadingStatus,
    String? userName,
    String? lunarSolar,
    DateTime? birthDate,
    String? gender,
    bool? unknownBirthTime,
    int? completedTodoCount,
    List<AnimalMarkerModel>? animalMarkerList,
  }) =>
      MyState(
        getUserDataLoadingStatus:
            getUserDataLoadingStatus ?? this.getUserDataLoadingStatus,
        getTodoListLoadingStatus:
            getTodoListLoadingStatus ?? this.getTodoListLoadingStatus,
        userName: userName ?? this.userName,
        lunarSolar: lunarSolar ?? this.lunarSolar,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        unknownBirthTime: unknownBirthTime ?? this.unknownBirthTime,
        completedTodoCount: completedTodoCount ?? this.completedTodoCount,
        animalMarkerList: animalMarkerList ?? this.animalMarkerList,
      );

  @override
  List<Object> get props => <Object>[
        getUserDataLoadingStatus,
        getTodoListLoadingStatus,
        userName,
        lunarSolar,
        birthDate,
        gender,
        unknownBirthTime,
        completedTodoCount,
        animalMarkerList,
      ];
}
