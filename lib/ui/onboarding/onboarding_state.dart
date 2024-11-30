import 'package:equatable/equatable.dart';
import '../common/consts/am_pm.dart';
import '../common/consts/gender.dart';
import '../common/consts/lunar_solar.dart';

class OnboardingState extends Equatable {
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

  const OnboardingState({
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
  });

  const OnboardingState.init()
      : gender = Gender.male,
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
        isAgreeTerms = false;

  OnboardingState copyWith({
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
  }) =>
      OnboardingState(
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
      );

  @override
  List<Object> get props => <Object>[
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
}
