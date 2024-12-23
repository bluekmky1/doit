import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widgets/accordion_card_widget.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridItemSpacing = screenWidth / 375 * 12;
    final double gridItemRunSpacing = screenWidth / 375 * 16;

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
              // const ElevatedCardWidget(
              //   height: 220,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         '미션 달성 그래프',
              //         style: DoitTypos.suitSB16,
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 36,
              // ),
              // 내가 도전한 목표
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    '이번달에 모은 동물들',
                    style: DoitTypos.suitSB16,
                  ),
                  Text(
                    '48마리',
                    style: DoitTypos.suitSB16.copyWith(
                      color: doitColorTheme.main,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
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
                ],
              ),
              Divider(
                height: 48,
                thickness: 3,
                color: doitColorTheme.gray20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '이전에 모은 동물들',
                    style: DoitTypos.suitSB16,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List<Widget>.generate(
                3,
                (int index) => const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: _CompletedTodoCardWidget(),
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

class _CompletedTodoCardWidget extends StatelessWidget {
  const _CompletedTodoCardWidget();

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
                '2024년 01월',
                style: DoitTypos.suitR14.copyWith(
                  color: doitColorTheme.gray60,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: TextChipWidget(
                  title: '완료한 할 일 74개',
                  padding: EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ],
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

          // TODO: 월 별 농장으로 이동하는 버튼 추가 기획 필요
          // const SizedBox(height: 12),
          // TextButton(
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.zero,
          //       backgroundColor: doitColorTheme.main,
          //       foregroundColor: doitColorTheme.background,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     onPressed: () {},
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Text(
          //           '농장으로 이동',
          //           style: DoitTypos.suitR14.copyWith(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ],
          //     ))
        ],
      ),
    );
  }
}
