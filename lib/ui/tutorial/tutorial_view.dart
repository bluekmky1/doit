import 'package:flame_lottie/flame_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';

class TutorialView extends ConsumerStatefulWidget {
  const TutorialView({super.key});

  @override
  ConsumerState<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends ConsumerState<TutorialView> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double pageheight = MediaQuery.of(context).size.width / 375 * 480;

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Scaffold(
      backgroundColor: doitColorTheme.background,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        scrolledUnderElevation: 0.0,
        backgroundColor: doitColorTheme.background,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: doitColorTheme.main,
            ),
            onPressed: () => context.goNamed(Routes.home.name),
            child: const Text('건너뛰기'),
          ),
        ],
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
            _currentPage == 3
                ? context.goNamed(Routes.home.name)
                : _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
          },
          child: Text(
            _currentPage == 3 ? '시작하기' : '다음',
            style: DoitTypos.suitR20.copyWith(
              color: doitColorTheme.background,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: pageheight,
              child: PageView(
                controller: _controller,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const <Widget>[
                  _TutorialPage1(),
                  _TutorialPage2(),
                  _TutorialPage3(),
                  _TutorialPage4(),
                ],
              ),
            ),
            Expanded(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: ExpandingDotsEffect(
                  dotColor: doitColorTheme.gray20,
                  activeDotColor: doitColorTheme.main,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 2,
                  spacing: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TutorialPage1 extends StatelessWidget {
  const _TutorialPage1();

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Image.asset(Assets.tutorialFirstImage),
          const Text(
            '무엇을 해야할지 고민된다면,\n오늘의 운세에 맞는 할 일을 먼저 진행해보세요.',
            textAlign: TextAlign.center,
            style: DoitTypos.suitSB16,
          ),
        ],
      );
}

class _TutorialPage2 extends StatelessWidget {
  const _TutorialPage2();

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Image.asset(Assets.tutorialSecondImage),
          const Text(
            '오늘의 할 일을 완료하면,\n동물들을 랜덤으로 수집할 수 있어요.',
            textAlign: TextAlign.center,
            style: DoitTypos.suitSB16,
          ),
        ],
      );
}

class _TutorialPage3 extends StatefulWidget {
  const _TutorialPage3();

  @override
  State<_TutorialPage3> createState() => _TutorialPage3State();
}

class _TutorialPage3State extends State<_TutorialPage3>
    with TickerProviderStateMixin {
  late AnimationController _appearController;
  late AnimationController _stopController;
  bool _showSecondAnimation = false;

  @override
  void initState() {
    _appearController = AnimationController(vsync: this);
    _stopController = AnimationController(vsync: this);

    _appearController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSecondAnimation = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _appearController.dispose();
    _stopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(Assets.kingBackground),
                if (!_showSecondAnimation)
                  Positioned(
                    top: 100,
                    child: Lottie.asset(
                      controller: _appearController,
                      Assets.kingMouseAppear,
                      onLoaded: (LottieComposition composition) {
                        _appearController
                          ..duration = composition.duration
                          ..forward();
                      },
                      height: 210,
                      width: 210,
                      fit: BoxFit.contain,
                    ),
                  ),
                Opacity(
                  opacity: _showSecondAnimation ? 1 : 0,
                  child: Lottie.asset(
                    controller: _stopController,
                    Assets.kingMouseStop,
                    onLoaded: (LottieComposition composition) {
                      _stopController
                        ..duration = composition.duration
                        ..repeat();
                    },
                    height: 180,
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          const Text(
            '특정한 조건에 맞춰 목표를 달성하면\n히든 동물을 제공해드려요.',
            textAlign: TextAlign.center,
            style: DoitTypos.suitSB16,
          ),
        ],
      );
}

class _TutorialPage4 extends StatefulWidget {
  const _TutorialPage4();

  @override
  State<_TutorialPage4> createState() => _TutorialPage4State();
}

class _TutorialPage4State extends State<_TutorialPage4>
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
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        Assets.gameBackground,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
              ],
            ),
          ),
          const Text(
            '이제, 당신의 목표를 달성하러 가볼까요?',
            textAlign: TextAlign.center,
            style: DoitTypos.suitSB16,
          ),
        ],
      );
}
