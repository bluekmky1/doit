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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fortuneViewModelProvider.notifier).getUserData();
      ref.read(fortuneViewModelProvider.notifier).getFortune();
    });
  }

  @override
  Widget build(BuildContext context) {
    final FortuneState state = ref.watch(fortuneViewModelProvider);

    ref.listen(
        fortuneViewModelProvider
            .select((FortuneState state) => state.getFortuneLoadingStatus),
        (LoadingStatus? previous, LoadingStatus next) {
      if (next == LoadingStatus.error) {}
    });

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

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
              ],
            ),
          ),
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
          if (state.getFortuneLoadingStatus == LoadingStatus.loading)
            Center(
              child: CircularProgressIndicator(
                color: doitColorTheme.main,
              ),
            ),
          if (state.getFortuneLoadingStatus == LoadingStatus.success &&
              !state.isTodayFortune)
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
                    '오늘의 특별한 운세가 도착했어요!',
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
