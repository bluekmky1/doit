import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../onboarding_state.dart';
import '../onboarding_view_model.dart';
import '../widgets/onboarding_app_bar.dart';

class OnboardingStartView extends ConsumerStatefulWidget {
  const OnboardingStartView({
    super.key,
  });

  @override
  ConsumerState<OnboardingStartView> createState() =>
      _OnboardingStartViewState();
}

class _OnboardingStartViewState extends ConsumerState<OnboardingStartView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 28),
      vsync: this,
    )..repeat();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.4, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final OnboardingState state = ref.watch(onboardingViewModelProvider);

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Scaffold(
      appBar: OnboardingAppBar(
        pageController: PageController(),
      ),
      bottomNavigationBar: SizedBox(
        height: 64,
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: doitColorTheme.main,
            foregroundColor: doitColorTheme.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            context.pushNamed(Routes.onboardingUserProfileInput.name);
          },
          child: Text(
            '시작하기',
            style: DoitTypos.suitSB20.copyWith(
              color: doitColorTheme.background,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '작은 성취로\n꾸준히 성장해보세요',
                  style: DoitTypos.suitSB20.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 28,
                    height: 1.4,
                    color: doitColorTheme.main,
                  ),
                ),
                const Text(
                  '운세 기반의 맞춤 목표와 미션으로\n'
                  '꾸준한 성취를 통해 성장을 도와드려요.',
                  style: DoitTypos.suitR16,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SlideTransition(
                    position: _offsetAnimation,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Lottie.asset(
                            Assets.mouseMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.cowMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.tigerMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.rabbitMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.dragonMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.snakeMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.horseMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.sheepMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.chickenMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.dogMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.monkeyMove,
                            fit: BoxFit.fitHeight,
                          ),
                          const SizedBox(width: 40),
                          Lottie.asset(
                            Assets.pigMove,
                            fit: BoxFit.fitHeight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
