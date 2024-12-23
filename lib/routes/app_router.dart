import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/fortune/fortune_view.dart';
import '../ui/goal/views/new_goal_duration_setting_view.dart';
import '../ui/goal/views/new_goal_setting_view.dart';
import '../ui/home/home_view.dart';
import '../ui/my/my_view.dart';
import '../ui/onboarding/views/goal_duration_setting_view.dart';
import '../ui/onboarding/views/goal_setting_view.dart';
import '../ui/onboarding/views/onboarding_start_view.dart';
import '../ui/onboarding/views/user_profile_input_view.dart';
import '../ui/tutorial/tutorial_view.dart';
import 'app_router_interceptor.dart';
import 'redirect_notifier.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((Ref<AppRouter> ref) => AppRouter(
          appRouterInterceptor: AppRouterInterceptor(ref: ref),
          refreshListenable: ref.read(redirectNotifierProvider),
        ));

CustomTransitionPage<T> buildPageWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      // firebaseAnalytics
      name: state.name,
      transitionDuration: const Duration(milliseconds: 80),
      reverseTransitionDuration: const Duration(milliseconds: 80),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          FadeTransition(opacity: animation, child: child),
    );

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  AppRouter({
    required Listenable refreshListenable,
    required AppRouterInterceptor appRouterInterceptor,
  })  : _appRouterInterceptor = appRouterInterceptor,
        _refreshListenable = refreshListenable;

  final AppRouterInterceptor _appRouterInterceptor;
  final Listenable _refreshListenable;

  // 라우트의 이동마다 호출됩니다.
  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) =>
      _appRouterInterceptor.redirect(context, state);

  late final GoRouter _router = GoRouter(
    initialLocation: Routes.home.name,
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    refreshListenable: _refreshListenable,
    errorBuilder: (BuildContext context, GoRouterState state) => const Scaffold(
      body: Center(
        child: Text('Internal Error'),
      ),
    ),
    redirect: _redirect,
    routes: <RouteBase>[
      GoRoute(
        name: Routes.onboardingStart.name,
        path: Routes.onboardingStart.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const OnboardingStartView(),
        ),
      ),
      GoRoute(
        name: Routes.onboardingUserProfileInput.name,
        path: Routes.onboardingUserProfileInput.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const UserProfileInputPage(),
        ),
      ),
      GoRoute(
        name: Routes.onboardingGoalSetting.name,
        path: Routes.onboardingGoalSetting.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const GoalSettingView(),
        ),
      ),
      GoRoute(
        name: Routes.onboardingGoalDurationSetting.name,
        path: Routes.onboardingGoalDurationSetting.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const GoalDurationSettingView(),
        ),
      ),
      GoRoute(
        name: Routes.tutorial.name,
        path: Routes.tutorial.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const TutorialView(),
        ),
      ),
      GoRoute(
        name: Routes.goalSetting.name,
        path: Routes.goalSetting.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: NewGoalSettingView(),
        ),
      ),
      GoRoute(
        name: Routes.goalDurationSetting.name,
        path: Routes.goalDurationSetting.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: NewGoalDurationSettingView(),
        ),
      ),
      GoRoute(
          name: Routes.home.name,
          path: Routes.home.path,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<dynamic>(
                child: HomeView(),
              ),
          routes: <RouteBase>[
            GoRoute(
              name: Routes.fortune.name,
              path: Routes.fortune.path,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<dynamic>(
                child: FortuneView(),
              ),
            ),
            GoRoute(
              name: Routes.my.name,
              path: Routes.my.path,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<dynamic>(
                child: MyView(),
              ),
            ),
          ]),

      // Auth
      // GoRoute(
      //   path: Routes.auth.path,
      //   name: Routes.auth.name,
      //   redirect: (BuildContext context, GoRouterState state) {
      //     if (state.fullPath == null || state.fullPath == Routes.auth.path) {
      //       return Routes.signIn.name;
      //     }
      //     return null;
      //   },
      //   routes: <RouteBase>[
      //     GoRoute(
      //         name: Routes.signIn.name,
      //         path: Routes.signIn.path,
      //         pageBuilder: (BuildContext context, GoRouterState state) =>
      //             const NoTransitionPage<dynamic>(
      //               child: SignInView(),
      //             ),
      //         routes: <RouteBase>[
      //           GoRoute(
      //             name: Routes.signUp.name,
      //             path: Routes.signUp.path,
      //             pageBuilder: (BuildContext context, GoRouterState state) =>
      //                 const NoTransitionPage<dynamic>(
      //               child: SignUpView(),
      //             ),
      //           ),
      //         ]),
      //   ],
      // ),
    ],
  );

  GoRouter get router => _router;
}
