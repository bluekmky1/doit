import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/user/model/user_data_model.dart';
import '../../domain/user/use_case/update_user_data.dart';
import '../../service/supabase/supabase_service.dart';
import '../common/consts/am_pm.dart';
import '../common/consts/gender.dart';
import '../common/consts/lunar_solar.dart';
import 'profile_state.dart';

final AutoDisposeStateNotifierProvider<ProfileViewModel, ProfileState>
    profileViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => ProfileViewModel(
    state: const ProfileState.init(),
    updateUserDataUseCase: ref.read(updateUserDataUseCaseProvider),
    supabaseClient: ref.read(supabaseServiceProvider),
  ),
);

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel({
    required ProfileState state,
    required UpdateUserDataUseCase updateUserDataUseCase,
    required SupabaseClient supabaseClient,
  })  : _updateUserDataUseCase = updateUserDataUseCase,
        _supabaseClient = supabaseClient,
        super(state);

  final UpdateUserDataUseCase _updateUserDataUseCase;
  final SupabaseClient _supabaseClient;

  Future<void> saveProfile() async {
    state = state.copyWith(updateProfileLoadingStatus: LoadingStatus.loading);

    final String? userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      return;
    }
    final UserDataModel profile = UserDataModel(
      id: userId,
      nickname: state.userName,
      gender: state.gender.title,
      lunarSolar: state.lunarSolar.title,
      birthDate: state.isBirthDateUnknown
          ? DateTime(
              int.parse(state.birthYear),
              int.parse(state.birthMonth),
              int.parse(state.birthDay),
            )
          : DateTime(
              int.parse(state.birthYear),
              int.parse(state.birthMonth),
              int.parse(state.birthDay),
              int.parse(state.birthHour),
              int.parse(state.birthMinute),
            ),
      unknownBirthTime: state.isBirthDateUnknown,
      consent: true,
    );

    final UseCaseResult<void> result = await _updateUserDataUseCase(
      data: profile,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          updateProfileLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<void>():
        state = state.copyWith(
          updateProfileLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void changeUserName({required String userName}) {
    state = state.copyWith(userName: userName);
  }

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
}
