import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/consts/am_pm.dart';
import '../common/consts/gender.dart';
import '../common/consts/lunar_solar.dart';
import 'onboarding_state.dart';

final AutoDisposeStateNotifierProvider<OnboardingViewModel, OnboardingState>
    onboardingViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => OnboardingViewModel(
    state: const OnboardingState.init(),
  ),
);

class OnboardingViewModel extends StateNotifier<OnboardingState> {
  OnboardingViewModel({
    required OnboardingState state,
  }) : super(state);

  void changeGender({required Gender gender}) {
    state = state.copyWith(gender: gender);
  }

  void changeLunarSolar({required LunarSolar lunarSolar}) {
    state = state.copyWith(lunarSolar: lunarSolar);
  }

  void changeBirthYear({required String birthYear}) {
    final int? year = int.tryParse(birthYear);
    if (year == null || year < 1800) {
      state = state.copyWith(birthYearError: '1800년 이전에 태어나셨나요??');
      return;
    }
    state = state.copyWith(
      birthYear: birthYear,
      birthYearError: '',
    );
  }

  void changeBirthMonth({required String birthMonth}) {
    final int? month = int.tryParse(birthMonth);
    if (month == null || month < 1 || month > 12) {
      state = state.copyWith(birthMonthError: '올바른 월을 입력해주세요.');
      return;
    }
    state = state.copyWith(
      birthMonth: birthMonth,
      birthMonthError: '',
    );
  }

  void changeBirthDay({required String birthDay}) {
    final int? day = int.tryParse(birthDay);
    if (day == null || day < 1) {
      state = state.copyWith(birthDayError: '올바른 일을 입력해주세요.');
      return;
    }

    // 월 정보 가져오기
    final int? month = int.tryParse(state.birthMonth);
    if (month == null) {
      state = state.copyWith(birthDayError: '월을 먼저 입력해주세요.');
      return;
    }

    // 월별 최대 일수 체크
    int maxDays;
    if (month == 2) {
      // 윤년 체크
      final int? year = int.tryParse(state.birthYear);
      if (year == null) {
        state = state.copyWith(birthDayError: '연도를 먼저 입력해주세요.');
        return;
      }
      final bool isLeapYear =
          (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      maxDays = isLeapYear ? 29 : 28;
    } else if (<int>[4, 6, 9, 11].contains(month)) {
      maxDays = 30;
    } else {
      maxDays = 31;
    }

    if (day > maxDays) {
      state = state.copyWith(birthDayError: '$month월은 $maxDays일까지입니다.');
      return;
    }

    state = state.copyWith(
      birthDay: birthDay,
      birthDayError: '',
    );
  }

  void changeAmPm({required AmPm amPm}) {
    state = state.copyWith(amPm: amPm);
  }

  void changeBirthHour({required String birthHour}) {
    final int? hour = int.tryParse(birthHour);
    if (hour == null || hour < 1 || hour > 12) {
      state = state.copyWith(birthHourError: '올바른 시간을 입력해주세요.');
      return;
    }
    state = state.copyWith(
      birthHour: birthHour,
      birthHourError: '',
    );
  }

  void changeBirthMinute({required String birthMinute}) {
    final int? minute = int.tryParse(birthMinute);
    if (minute == null || minute < 0 || minute > 59) {
      state = state.copyWith(birthMinuteError: '올바른 분을 입력해주세요.');
      return;
    }
    state = state.copyWith(
      birthMinute: birthMinute,
      birthMinuteError: '',
    );
  }

  void changeIsBirthDateUnknown({required bool isBirthDateUnknown}) {
    state = state.copyWith(isBirthDateUnknown: isBirthDateUnknown);
  }

  void changeIsAgreeTerms({required bool isAgreeTerms}) {
    state = state.copyWith(isAgreeTerms: isAgreeTerms);
  }

  void selectGoalForUser({required String goalForUser}) {
    if (state.goalForUser == goalForUser) {
      state = state.copyWith(goalForUser: state.goalForUserInput);
      return;
    }
    state = state.copyWith(goalForUser: goalForUser);
  }

  void changeGoalForUserInput({required String goalForUserInput}) {
    if (state.recommendedGoal.contains(goalForUserInput)) {
      state = state.copyWith(
        goalForUser: goalForUserInput,
        goalForUserInput: '',
      );
      return;
    }
    state = state.copyWith(
      goalForUserInput: goalForUserInput,
      goalForUser: goalForUserInput,
    );
  }

  void changeGoalStartYear({required String startYear}) {
    state = state.copyWith(startYear: startYear);
  }

  void changeGoalStartMonth({required String startMonth}) {
    state = state.copyWith(startMonth: startMonth);
  }

  void changeGoalStartDay({required String startDay}) {
    state = state.copyWith(startDay: startDay);
  }

  void changeGoalEndYear({required String endYear}) {
    state = state.copyWith(endYear: endYear);
  }

  void changeGoalEndMonth({required String endMonth}) {
    state = state.copyWith(endMonth: endMonth);
  }

  void changeGoalEndDay({required String endDay}) {
    state = state.copyWith(endDay: endDay);
  }
}
