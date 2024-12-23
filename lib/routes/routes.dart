import 'route_info.dart';

class Routes {
  // auth
  // static const RouteInfo auth = RouteInfo(
  //   name: '/auth',
  //   path: '/auth',
  // );

  // static const RouteInfo signIn = RouteInfo(
  //   name: '/auth/sign-in',
  //   path: 'sign-in',
  // );

  // static const RouteInfo signUp = RouteInfo(
  //   name: '/auth/sign-up',
  //   path: 'sign-up',
  // );

  // 온보딩 시작 페이지
  static const RouteInfo onboardingStart = RouteInfo(
    name: '/onboarding/start',
    path: '/onboarding/start',
  );

  // 유저 정보 입력 온보딩
  static const RouteInfo onboardingUserProfileInput = RouteInfo(
    name: '/onboarding/user-profile-input',
    path: '/onboarding/user-profile-input',
  );

  // 목표 설정 온보딩
  static const RouteInfo onboardingGoalSetting = RouteInfo(
    name: '/onboarding/goal-setting',
    path: '/onboarding/goal-setting',
  );

  // 목표 기간 설정 온보딩
  static const RouteInfo onboardingGoalDurationSetting = RouteInfo(
    name: '/onboarding/duration-setting',
    path: '/onboarding/duration-setting',
  );

  // 튜토리얼 페이지
  static const RouteInfo tutorial = RouteInfo(
    name: '/tutorial',
    path: '/tutorial',
  );

  // 홈(메인)페이지
  static const RouteInfo home = RouteInfo(
    name: '/home',
    path: '/home',
  );

  // 목표 설정 페이지
  static const RouteInfo goalSetting = RouteInfo(
    name: '/goal/setting',
    path: '/goal/setting',
  );

  // 목표 기간 설정 페이지
  static const RouteInfo goalDurationSetting = RouteInfo(
    name: '/goal/duration-setting',
    path: '/goal/duration-setting',
  );

  // 운세 페이지
  static const RouteInfo fortune = RouteInfo(
    name: '/home/fortune',
    path: 'fortune',
  );

  // 마이페이지
  static const RouteInfo my = RouteInfo(
    name: '/home/my',
    path: 'my',
  );
}
