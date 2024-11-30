import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widgets/accordion_card_widget.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import '../common/widgets/elevated_card_widget.dart';
import '../common/widgets/text_chip_widget.dart';
import 'widgets/my_app_bar_widget.dart';

class MyView extends ConsumerStatefulWidget {
  const MyView({super.key});

  @override
  ConsumerState<MyView> createState() => _MyViewState();
}

class _MyViewState extends ConsumerState<MyView> {
  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Scaffold(
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.my.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              // 앱바
              MyAppBarWidget(doitColorTheme: doitColorTheme),
              // 목표 달성 그래프
              const ElevatedCardWidget(
                height: 220,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '미션 달성 그래프',
                      style: DoitTypos.suitSB16,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              // 내가 도전한 목표
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    '내가 도전한 목표',
                    style: DoitTypos.suitSB16,
                  ),
                  Text(
                    '48개',
                    style: DoitTypos.suitSB16.copyWith(
                      color: doitColorTheme.main,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List<Widget>.generate(
                3,
                (int index) => const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: _ChallengedGoalCardWidget(),
                ),
              ),

              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChallengedGoalCardWidget extends StatelessWidget {
  const _ChallengedGoalCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridItemSpacing = screenWidth / 375 * 12;
    final double gridItemRunSpacing = screenWidth / 375 * 16;
    return AccordionCardWidget(
      titleChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '2024.01.01 - 2024.12.31',
                style: DoitTypos.suitR10.copyWith(
                  color: doitColorTheme.gray60,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: TextChipWidget(
                  title: '성공 미션 74개',
                  padding: EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '바리스타 자격증 취득 바리스타 자격증 취득',
            style: DoitTypos.suitR14,
          ),
        ],
      ),
      bodyChild: Column(
        children: <Widget>[
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 한 줄에 4개
              childAspectRatio: 2 / 1, // 가로:세로 = 2:1
              crossAxisSpacing: gridItemSpacing, // 가로 간격
              mainAxisSpacing: gridItemRunSpacing, // 세로 간격
            ),
            itemCount: 12, // 4개씩 3줄 = 12개
            itemBuilder: (BuildContext context, int index) => Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(
                  color: doitColorTheme.gray20,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const Positioned(
                    left: 12,
                    child: Text(
                      '12',
                      style: DoitTypos.suitSB16,
                    ),
                  ),
                  Positioned(
                    left: 40,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(Assets.allLuck),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: doitColorTheme.main,
                foregroundColor: doitColorTheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '목표 농장으로 이동',
                    style: DoitTypos.suitR14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
