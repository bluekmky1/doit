import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'widgets/card_slider_widget.dart';
import 'widgets/circular_graph_widget.dart';
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
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Scaffold(
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.fortune.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const FortuneAppBarWidget(),
            const IconCardListWidget(),
            const FortuneScoreGageWidget(
              title: '총운',
              score: 80,
            ),
            const FortuneCardWidget(
              // shortFortune: '전력질주하기 좋은날',
              fullFortune:
                  '''힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날힘든 일이 있어도 어렵지 않게 미소가 생기는 날''',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              child: Text(
                '시간대 별 운세',
                style: DoitTypos.suitR12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularGraphWidget(
                    percentage: 84,
                    gradiantStart: doitColorTheme.gradient2Stop0,
                    gradiantEnd: doitColorTheme.gradient2Stop100,
                    timeTitle: '낮',
                  ),
                  CircularGraphWidget(
                    percentage: 84,
                    gradiantStart: doitColorTheme.gradient1Stop42,
                    gradiantEnd:
                        doitColorTheme.gradient1Stop100.withOpacity(0.42),
                    timeTitle: '오후',
                  ),
                  CircularGraphWidget(
                    percentage: 84,
                    gradiantStart: doitColorTheme.gradient3Stop0,
                    gradiantEnd: doitColorTheme.gradient3Stop100,
                    timeTitle: '밤',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.fortuneColored,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '오늘의 운세 기반 추천 미션',
                    style: DoitTypos.suitSB16,
                  ),
                ],
              ),
            ),
            const CardSliderWidget(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
