import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/loading_status.dart';
import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../common/consts/fortune_category.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'fortune_state.dart';
import 'fortune_view_model.dart';
import 'widgets/fortune_app_bar_widget.dart';
import 'widgets/fortune_card_widget.dart';
import 'widgets/fortune_score_gage_widget.dart';
import 'widgets/icon_card_widget.dart';

class FortuneView extends ConsumerStatefulWidget {
  const FortuneView({super.key});

  @override
  ConsumerState<FortuneView> createState() => _FortuneViewState();
}

class _FortuneViewState extends ConsumerState<FortuneView> {
  final List<String> loadingMessages = <String>[
    '사주를 분석하고 있어요...',
    '운세를 살펴보는 중이에요...',
    '오늘의 운세를 풀이하고 있어요...',
    '조금만 더 기다려주세요...',
    '거의 다 왔어요!',
  ];

  int currentMessageIndex = 0;
  Timer? messageTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fortuneViewModelProvider.notifier).getUserData();
      ref.read(fortuneViewModelProvider.notifier).getFortune();
    });
  }

  @override
  void dispose() {
    messageTimer?.cancel();
    super.dispose();
  }

  void startLoadingMessages() {
    messageTimer?.cancel();
    currentMessageIndex = 0;
    messageTimer = Timer.periodic(
      const Duration(milliseconds: 2500),
      (Timer timer) {
        if (mounted) {
          setState(() {
            currentMessageIndex =
                (currentMessageIndex + 1) % loadingMessages.length;
          });
        }
      },
    );
  }

  void stopLoadingMessages() {
    messageTimer?.cancel();
    messageTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final FortuneState state = ref.watch(fortuneViewModelProvider);

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    // createFortuneLoadingStatus 상태 변화 감지
    ref.listen(
      fortuneViewModelProvider
          .select((FortuneState state) => state.createFortuneLoadingStatus),
      (LoadingStatus? previous, LoadingStatus next) {
        if (next == LoadingStatus.loading) {
          startLoadingMessages();
        } else {
          stopLoadingMessages();
          currentMessageIndex = 0;
        }
      },
    );

    return Scaffold(
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.fortune.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const FortuneAppBarWidget(),
                const IconCardListWidget(),
                FortuneScoreGageWidget(
                  title: state.selectedFortuneCategory.title,
                  score: state.selectedFortuneScore,
                ),
                FortuneCardWidget(
                  shortFortune:
                      state.selectedFortuneCategory == FortuneCategory.total
                          ? state.fortuneSummary
                          : null,
                  fullFortune: state.selectedFortuneCategoryContent,
                ),
                const SizedBox(height: 32),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 23.5,
                //   ),
                //   child: Row(
                //     children: <Widget>[
                //       SizedBox(
                //         child: SvgPicture.asset(
                //           Assets.fortuneColored,
                //           width: 24,
                //           height: 24,
                //         ),
                //       ),
                //       const SizedBox(width: 8),
                //       const Text(
                //         '추천 할 일 목록',
                //         style: DoitTypos.suitSB16,
                //       ),
                //     ],
                //   ),
                // ),
                // const CardSliderWidget(),
              ],
            ),
          ),
          // 운세 조회 중 OR 운세 조회 실패 OR 조회를 성공했더라도 오늘의 운세가 아니라면 블러 효과
          if (state.getFortuneLoadingStatus != LoadingStatus.success ||
              !state.isTodayFortune)
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 6.5,
                sigmaY: 6.5,
              ),
              child: Container(
                color: Colors.white.withOpacity(0.3),
                height: MediaQuery.of(context).size.height,
              ),
            ),

          // 운세 조회 중 로딩 인디케이터
          if (state.getFortuneLoadingStatus == LoadingStatus.loading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    color: doitColorTheme.main,
                  ),
                  const SizedBox(height: 20),
                  if (state.createFortuneLoadingStatus == LoadingStatus.loading)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        loadingMessages[currentMessageIndex],
                        key: ValueKey<String>(
                            loadingMessages[currentMessageIndex]),
                        style: DoitTypos.suitSB16,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          // 운세 생성 실패 시 오류 메시지
          if (state.createFortuneLoadingStatus == LoadingStatus.error)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.warning,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '운세를 불러오는데 실패했어요!\n관리자에게 문의해주세요.',
                    style: DoitTypos.suitSB16,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

          // 운세 조회 실패 시 생성 버튼 활성화 또는 오늘의 운세가 아닐 경우 로딩중이 아닐 때는 숨김
          if (state.getFortuneLoadingStatus != LoadingStatus.loading &&
              state.getFortuneLoadingStatus != LoadingStatus.none &&
              (state.getFortuneLoadingStatus == LoadingStatus.error ||
                  !state.isTodayFortune))
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.fortuneColored,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '오늘의 특별한 운세를 확인해보세요!',
                    style: DoitTypos.suitSB16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: doitColorTheme.main,
                      foregroundColor: doitColorTheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(fortuneViewModelProvider.notifier)
                          .createFortune();
                    },
                    child: const Text(
                      '운세 받아오기',
                      style: DoitTypos.suitSB16,
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
