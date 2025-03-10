import 'route_info.dart';

class Routes {
  // 로그인 페이지
  static const RouteInfo signIn = RouteInfo(
    name: '/sign-in',
    path: '/sign-in',
  );

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

  // 프로필 페이지
  static const RouteInfo profile = RouteInfo(
    name: '/home/my/profile',
    path: 'profile',
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

  // 루틴 페이지
  static const RouteInfo routine = RouteInfo(
    name: '/home/my/routine',
    path: 'routine',
  );

  // 농장 페이지
  static const RouteInfo farm = RouteInfo(
    name: '/home/farm',
    path: 'farm',
  );
}
