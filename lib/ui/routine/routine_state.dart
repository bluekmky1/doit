import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/routine/model/routine_model.dart';

class RoutineState extends Equatable {
  final LoadingStatus getRoutineListLoadingStatus;
  final LoadingStatus createRoutineLoadingStatus;
  final LoadingStatus updateRoutineActiveLoadingStatus;
  final LoadingStatus deleteRoutineLoadingStatus;
  final List<RoutineModel> routineList;

  const RoutineState({
    required this.getRoutineListLoadingStatus,
    required this.createRoutineLoadingStatus,
    required this.updateRoutineActiveLoadingStatus,
    required this.deleteRoutineLoadingStatus,
    required this.routineList,
  });

  RoutineState.init()
      : getRoutineListLoadingStatus = LoadingStatus.none,
        createRoutineLoadingStatus = LoadingStatus.none,
        updateRoutineActiveLoadingStatus = LoadingStatus.none,
        deleteRoutineLoadingStatus = LoadingStatus.none,
        routineList = <RoutineModel>[];

  RoutineState copyWith({
    LoadingStatus? getRoutineListLoadingStatus,
    LoadingStatus? createRoutineLoadingStatus,
    LoadingStatus? updateRoutineActiveLoadingStatus,
    LoadingStatus? deleteRoutineLoadingStatus,
    List<RoutineModel>? routineList,
  }) =>
      RoutineState(
        getRoutineListLoadingStatus:
            getRoutineListLoadingStatus ?? this.getRoutineListLoadingStatus,
        createRoutineLoadingStatus:
            createRoutineLoadingStatus ?? this.createRoutineLoadingStatus,
        updateRoutineActiveLoadingStatus: updateRoutineActiveLoadingStatus ??
            this.updateRoutineActiveLoadingStatus,
        deleteRoutineLoadingStatus:
            deleteRoutineLoadingStatus ?? this.deleteRoutineLoadingStatus,
        routineList: routineList ?? this.routineList,
      );

  @override
  List<Object> get props => <Object>[
        getRoutineListLoadingStatus,
        createRoutineLoadingStatus,
        updateRoutineActiveLoadingStatus,
        deleteRoutineLoadingStatus,
        routineList,
      ];
}
