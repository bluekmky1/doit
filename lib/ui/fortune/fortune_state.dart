import 'package:equatable/equatable.dart';

import '../../core/loading_status.dart';
import '../../domain/fortune/model/fortune_detail_model.dart';
import '../../util/date_time_format_helper.dart';
import '../common/consts/fortune_category.dart';

class FortuneState extends Equatable {
  final LoadingStatus getUserDataLoadingStatus;
  final LoadingStatus getFortuneLoadingStatus;
  final LoadingStatus createFortuneLoadingStatus;

  // 유저 데이터
  final String userId;
  final String birthDate;
  final String birthTime;
  final String gender;

  // 운세 데이터
  final String fortuneSummary;
  final List<FortuneDetailModel> fortuneDetails;
  final DateTime fortuneCreatedAt;

  final FortuneCategory selectedFortuneCategory;

  const FortuneState({
    required this.getUserDataLoadingStatus,
    required this.getFortuneLoadingStatus,
    required this.createFortuneLoadingStatus,
    required this.selectedFortuneCategory,
    required this.userId,
    required this.birthDate,
    required this.birthTime,
    required this.gender,
    required this.fortuneSummary,
    required this.fortuneDetails,
    required this.fortuneCreatedAt,
  });

  FortuneState.init()
      : selectedFortuneCategory = FortuneCategory.total,
        getUserDataLoadingStatus = LoadingStatus.none,
        getFortuneLoadingStatus = LoadingStatus.none,
        createFortuneLoadingStatus = LoadingStatus.none,
        userId = '',
        birthDate = '',
        birthTime = '',
        gender = '',
        fortuneSummary = '',
        fortuneDetails = <FortuneDetailModel>[],
        fortuneCreatedAt = DateTime(2025);

  FortuneState copyWith({
    LoadingStatus? getUserDataLoadingStatus,
    LoadingStatus? getFortuneLoadingStatus,
    LoadingStatus? createFortuneLoadingStatus,
    FortuneCategory? selectedFortuneCategory,
    String? userId,
    String? birthDate,
    String? birthTime,
    String? gender,
    String? fortuneSummary,
    List<FortuneDetailModel>? fortuneDetails,
    DateTime? fortuneCreatedAt,
  }) =>
      FortuneState(
        getUserDataLoadingStatus:
            getUserDataLoadingStatus ?? this.getUserDataLoadingStatus,
        getFortuneLoadingStatus:
            getFortuneLoadingStatus ?? this.getFortuneLoadingStatus,
        createFortuneLoadingStatus:
            createFortuneLoadingStatus ?? this.createFortuneLoadingStatus,
        selectedFortuneCategory:
            selectedFortuneCategory ?? this.selectedFortuneCategory,
        userId: userId ?? this.userId,
        birthDate: birthDate ?? this.birthDate,
        birthTime: birthTime ?? this.birthTime,
        gender: gender ?? this.gender,
        fortuneSummary: fortuneSummary ?? this.fortuneSummary,
        fortuneDetails: fortuneDetails ?? this.fortuneDetails,
        fortuneCreatedAt: fortuneCreatedAt ?? this.fortuneCreatedAt,
      );

  @override
  List<Object> get props => <Object>[
        getUserDataLoadingStatus,
        getFortuneLoadingStatus,
        createFortuneLoadingStatus,
        selectedFortuneCategory,
        userId,
        birthDate,
        birthTime,
        gender,
        fortuneSummary,
        fortuneDetails,
        fortuneCreatedAt,
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
