import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/farm/farm_view.dart';
import '../ui/fortune/fortune_view.dart';
import '../ui/home/home_view.dart';
import '../ui/my/my_view.dart';
import '../ui/onboarding/views/onboarding_start_view.dart';
import '../ui/onboarding/views/user_profile_input_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/routine/routine_view.dart';
import '../ui/sign_in/sign_in_view.dart';
import '../ui/tutorial/tutorial_view.dart';
import 'app_router_interceptor.dart';
import 'redirect_notifier.dart';
import 'routes.dart';

final Provider<AppRouter> appRouterProvider =
    Provider<AppRouter>((Ref<AppRouter> ref) => AppRouter(
          appRouterInterceptor: AppRouterInterceptor(ref: ref),
          refreshListenable: ref.read(redirectNotifierProvider),
        ));

// 페이지 이동 애니메이션 (fade)
CustomTransitionPage<T> buildPageWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) =>
    CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
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

  // 라우트의 이동마다 호출되는 함수
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
        name: Routes.signIn.name,
        path: Routes.signIn.path,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const NoTransitionPage<dynamic>(
          child: SignInView(),
        ),
      ),
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
          name: Routes.home.name,
          path: Routes.home.path,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage<dynamic>(
                child: HomeView(),
              ),
          routes: <RouteBase>[
            GoRoute(
              name: Routes.farm.name,
              path: Routes.farm.path,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const NoTransitionPage<dynamic>(
                child: FarmView(),
              ),
            ),
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
              routes: <RouteBase>[
                GoRoute(
                  name: Routes.profile.name,
                  path: Routes.profile.path,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage<dynamic>(
                    child: ProfileView(),
                  ),
                ),
                GoRoute(
                  name: Routes.routine.name,
                  path: Routes.routine.path,
                  pageBuilder: (BuildContext context, GoRouterState state) =>
                      const NoTransitionPage<dynamic>(
                    child: RoutineView(),
                  ),
                )
              ],
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
