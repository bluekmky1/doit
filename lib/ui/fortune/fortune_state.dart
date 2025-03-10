import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';
import '../../domain/fortune/model/fortune_detail_model.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../../util/date_time_format_helper.dart';
import '../common/consts/fortune_category.dart';

class FortuneState extends Equatable {
  final LoadingStatus getUserDataLoadingStatus;
  final LoadingStatus getFortuneLoadingStatus;
  final LoadingStatus createFortuneLoadingStatus;
  final LoadingStatus getRecommendedTodoListLoadingStatus;
  final LoadingStatus addTodoByRecommendLoadingStatus;

  // 유저 데이터
  final String userId;
  final String birthDate;
  final String birthTime;
  final String gender;

  // 운세 데이터
  final String fortuneSummary;
  final List<FortuneDetailModel> fortuneDetails;
  final DateTime fortuneCreatedAt;

  // 추천 할일 목록
  final List<RecommendedTodoModel> recommendedTodoList;

  final FortuneCategory selectedFortuneCategory;

  const FortuneState({
    required this.getUserDataLoadingStatus,
    required this.getFortuneLoadingStatus,
    required this.createFortuneLoadingStatus,
    required this.getRecommendedTodoListLoadingStatus,
    required this.addTodoByRecommendLoadingStatus,
    required this.selectedFortuneCategory,
    required this.userId,
    required this.birthDate,
    required this.birthTime,
    required this.gender,
    required this.fortuneSummary,
    required this.fortuneDetails,
    required this.fortuneCreatedAt,
    required this.recommendedTodoList,
  });

  FortuneState.init()
      : selectedFortuneCategory = FortuneCategory.total,
        getUserDataLoadingStatus = LoadingStatus.none,
        getFortuneLoadingStatus = LoadingStatus.none,
        createFortuneLoadingStatus = LoadingStatus.none,
        getRecommendedTodoListLoadingStatus = LoadingStatus.none,
        addTodoByRecommendLoadingStatus = LoadingStatus.none,
        userId = '',
        birthDate = '',
        birthTime = '',
        gender = '',
        fortuneSummary = '',
        fortuneDetails = <FortuneDetailModel>[],
        fortuneCreatedAt = DateTime(2025),
        recommendedTodoList = <RecommendedTodoModel>[
          RecommendedTodoModel(
            id: '',
            content: 'asdasd',
            category: FortuneCategory.total.name,
            isAdded: false,
            createdAt: DateTime(2025),
          ),
        ];

  FortuneState copyWith({
    LoadingStatus? getUserDataLoadingStatus,
    LoadingStatus? getFortuneLoadingStatus,
    LoadingStatus? createFortuneLoadingStatus,
    LoadingStatus? getRecommendedTodoListLoadingStatus,
    LoadingStatus? addTodoByRecommendLoadingStatus,
    FortuneCategory? selectedFortuneCategory,
    String? userId,
    String? birthDate,
    String? birthTime,
    String? gender,
    String? fortuneSummary,
    List<FortuneDetailModel>? fortuneDetails,
    DateTime? fortuneCreatedAt,
    List<RecommendedTodoModel>? recommendedTodoList,
  }) =>
      FortuneState(
        getUserDataLoadingStatus:
            getUserDataLoadingStatus ?? this.getUserDataLoadingStatus,
        getFortuneLoadingStatus:
            getFortuneLoadingStatus ?? this.getFortuneLoadingStatus,
        createFortuneLoadingStatus:
            createFortuneLoadingStatus ?? this.createFortuneLoadingStatus,
        getRecommendedTodoListLoadingStatus:
            getRecommendedTodoListLoadingStatus ??
                this.getRecommendedTodoListLoadingStatus,
        addTodoByRecommendLoadingStatus: addTodoByRecommendLoadingStatus ??
            this.addTodoByRecommendLoadingStatus,
        selectedFortuneCategory:
            selectedFortuneCategory ?? this.selectedFortuneCategory,
        userId: userId ?? this.userId,
        birthDate: birthDate ?? this.birthDate,
        birthTime: birthTime ?? this.birthTime,
        gender: gender ?? this.gender,
        fortuneSummary: fortuneSummary ?? this.fortuneSummary,
        fortuneDetails: fortuneDetails ?? this.fortuneDetails,
        fortuneCreatedAt: fortuneCreatedAt ?? this.fortuneCreatedAt,
        recommendedTodoList: recommendedTodoList ?? this.recommendedTodoList,
      );

  @override
  List<Object> get props => <Object>[
        getUserDataLoadingStatus,
        getFortuneLoadingStatus,
        createFortuneLoadingStatus,
        getRecommendedTodoListLoadingStatus,
        addTodoByRecommendLoadingStatus,
        selectedFortuneCategory,
        userId,
        birthDate,
        birthTime,
        gender,
        fortuneSummary,
        fortuneDetails,
        fortuneCreatedAt,
        recommendedTodoList,
      ];

  int get selectedFortuneScore {
    if (fortuneDetails.isEmpty) {
      return 0;
    }

    return fortuneDetails
        .firstWhere((FortuneDetailModel element) =>
            element.category == selectedFortuneCategory)
        .score;
  }

  String get selectedFortuneCategoryContent {
    if (fortuneDetails.isEmpty) {
      return '';
    }

    return fortuneDetails
        .firstWhere((FortuneDetailModel element) =>
            element.category == selectedFortuneCategory)
        .content;
  }

  bool get isTodayFortune =>
      DateTimeFormatter.getFullDate(fortuneCreatedAt) ==
      DateTimeFormatter.getFullDate(DateTime.now());
}
