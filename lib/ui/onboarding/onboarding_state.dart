import 'package:equatable/equatable.dart';
import '../../core/loading_status.dart';
import '../common/consts/am_pm.dart';
import '../common/consts/gender.dart';
import '../common/consts/lunar_solar.dart';

class OnboardingState extends Equatable {
  final LoadingStatus postUserDataLoadingStatus;

  final Gender gender;
  final LunarSolar lunarSolar;
  final String birthYear;
  final String birthYearError;
  final String birthMonth;
  final String birthMonthError;
  final String birthDay;
  final String birthDayError;
  final AmPm amPm;
  final String birthHour;
  final String birthHourError;
  final String birthMinute;
  final String birthMinuteError;
  final bool isBirthDateUnknown;
  final bool isAgreeTerms;
  final String goalForUser;
  final String goalForUserInput;
  final List<String> recommendedGoal;
  final String startYear;
  final String startMonth;
  final String startDay;
  final String endYear;
  final String endMonth;
  final String endDay;

  const OnboardingState({
    required this.postUserDataLoadingStatus,
    required this.gender,
    required this.lunarSolar,
    required this.birthYear,
    required this.birthYearError,
    required this.birthMonth,
    required this.birthMonthError,
    required this.birthDay,
    required this.birthDayError,
    required this.amPm,
    required this.birthHour,
    required this.birthHourError,
    required this.birthMinute,
    required this.birthMinuteError,
    required this.isBirthDateUnknown,
    required this.isAgreeTerms,
    required this.goalForUser,
    required this.goalForUserInput,
    required this.recommendedGoal,
    required this.startYear,
    required this.startMonth,
    required this.startDay,
    required this.endYear,
    required this.endMonth,
    required this.endDay,
  });

  const OnboardingState.init()
      : postUserDataLoadingStatus = LoadingStatus.none,
        gender = Gender.male,
        lunarSolar = LunarSolar.solar,
        birthYear = '',
        birthYearError = '',
        birthMonth = '',
        birthMonthError = '',
        birthDay = '',
        birthDayError = '',
        amPm = AmPm.am,
        birthHour = '',
        birthHourError = '',
        birthMinute = '',
        birthMinuteError = '',
        isBirthDateUnknown = false,
        isAgreeTerms = false,
        goalForUser = '',
        goalForUserInput = '',
        recommendedGoal = const <String>[
          '오늘 하루 평범하게 보내기',
          '오늘 하루 최고로 보내기',
          '오늘 하루 최선으로 보내기',
        ],
        startYear = '',
        startMonth = '',
        startDay = '',
        endYear = '',
        endMonth = '',
        endDay = '';

  OnboardingState copyWith({
    LoadingStatus? postUserDataLoadingStatus,
    Gender? gender,
    LunarSolar? lunarSolar,
    String? birthYear,
    String? birthYearError,
    String? birthMonth,
    String? birthMonthError,
    String? birthDay,
    String? birthDayError,
    AmPm? amPm,
    String? birthHour,
    String? birthHourError,
    String? birthMinute,
    String? birthMinuteError,
    bool? isBirthDateUnknown,
    bool? isAgreeTerms,
    String? goalForUser,
    String? goalForUserInput,
    List<String>? recommendedGoal,
    String? startYear,
    String? startMonth,
    String? startDay,
    String? endYear,
    String? endMonth,
    String? endDay,
  }) =>
      OnboardingState(
        postUserDataLoadingStatus:
            postUserDataLoadingStatus ?? this.postUserDataLoadingStatus,
        gender: gender ?? this.gender,
        lunarSolar: lunarSolar ?? this.lunarSolar,
        birthYear: birthYear ?? this.birthYear,
        birthYearError: birthYearError ?? this.birthYearError,
        birthMonth: birthMonth ?? this.birthMonth,
        birthMonthError: birthMonthError ?? this.birthMonthError,
        birthDay: birthDay ?? this.birthDay,
        birthDayError: birthDayError ?? this.birthDayError,
        amPm: amPm ?? this.amPm,
        birthHour: birthHour ?? this.birthHour,
        birthHourError: birthHourError ?? this.birthHourError,
        birthMinute: birthMinute ?? this.birthMinute,
        birthMinuteError: birthMinuteError ?? this.birthMinuteError,
        isBirthDateUnknown: isBirthDateUnknown ?? this.isBirthDateUnknown,
        isAgreeTerms: isAgreeTerms ?? this.isAgreeTerms,
        goalForUser: goalForUser ?? this.goalForUser,
        goalForUserInput: goalForUserInput ?? this.goalForUserInput,
        recommendedGoal: recommendedGoal ?? this.recommendedGoal,
        startYear: startYear ?? this.startYear,
        startMonth: startMonth ?? this.startMonth,
        startDay: startDay ?? this.startDay,
        endYear: endYear ?? this.endYear,
        endMonth: endMonth ?? this.endMonth,
        endDay: endDay ?? this.endDay,
      );

  @override
  List<Object> get props => <Object>[
        postUserDataLoadingStatus,
        gender,
        lunarSolar,
        birthYear,
        birthYearError,
        birthMonth,
        birthMonthError,
        birthDay,
        birthDayError,
        amPm,
        birthHour,
        birthHourError,
        birthMinute,
        birthMinuteError,
        isBirthDateUnknown,
        isAgreeTerms,
        goalForUser,
        goalForUserInput,
        recommendedGoal,
        startYear,
        startMonth,
        startDay,
        endYear,
        endMonth,
        endDay,
      ];

  bool get isAllFormValid =>
      birthYearError.isEmpty &&
      birthYear.isNotEmpty &&
      birthMonthError.isEmpty &&
      birthMonth.isNotEmpty &&
      birthDayError.isEmpty &&
      birthDay.isNotEmpty &&
      (isBirthDateUnknown ||
          (birthHourError.isEmpty && birthMinuteError.isEmpty));

  bool get isGoalForUserValid => goalForUser.isNotEmpty;

  bool get isStartDateValid =>
      startYear.isNotEmpty && startMonth.isNotEmpty && startDay.isNotEmpty;

  bool get isDurationValid =>
      startYear.isNotEmpty &&
      startMonth.isNotEmpty &&
      startDay.isNotEmpty &&
      endYear.isNotEmpty &&
      endMonth.isNotEmpty &&
      endDay.isNotEmpty;
}
