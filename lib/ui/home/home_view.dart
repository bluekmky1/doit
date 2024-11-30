import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/card_slider_widget.dart';
import 'widgets/goal_status_bar_widget.dart';
import 'widgets/todo_list_item_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController mainAxisScrollController = ScrollController();
  // 스크롤이 맨 위(0.99)까지 갔을 때 1으로 이동ㅎ
  void _scrollListener() {
    if (mainAxisScrollController.offset <= 0.99) {
      mainAxisScrollController.jumpTo(1);
    }
  }

  @override
  void initState() {
    super.initState();
    mainAxisScrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).init();
    });
  }

  @override
  void dispose() {
    mainAxisScrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    // final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final double gameHeight = MediaQuery.of(context).size.width / 375 * 300;

    return Scaffold(
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        controller: mainAxisScrollController,
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        child: Column(
          children: <Widget>[
            // 게임 + 목표 바 들어갈 자리 ----------------------------------
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: doitColorTheme.shadow1.withOpacity(0.2),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // 게임
                  Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    color: const Color(0xFF27358C),
                    height: gameHeight,
                  ),
                  // 농장으로 가기 버튼
                  Positioned(
                    right: 16,
                    bottom: 90,
                    child: IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: doitColorTheme.background,
                      ),
                      icon: SvgPicture.asset(Assets.pawColored),
                    ),
                  ),
                  // 목표 바
                  const GoalStatusBarWidget(),
                ],
              ),
            ),
            // 투두 리스트 ----------------------------------
            // 운세 기반 추천 미션
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(Assets.fortuneColored),
                  const SizedBox(width: 10),
                  const Text(
                    '오늘의 운세 기반 추천 할 일',
                    style: DoitTypos.suitSB16,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 32,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: doitColorTheme.main,
                        foregroundColor: doitColorTheme.background,
                      ),
                      child: Text(
                        '추가로 받기',
                        style: DoitTypos.suitR12
                            .copyWith(color: doitColorTheme.background),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CardSliderWidget(),

            //  내가 추가한 할 일
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(Assets.fortuneColored),
                  const SizedBox(width: 10),
                  const Text(
                    '내가 추가한 할 일',
                    style: DoitTypos.suitSB16,
                  ),
                  const Spacer(),
                  IconButton(
                    constraints: const BoxConstraints(),
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      Assets.add,
                      colorFilter: ColorFilter.mode(
                        doitColorTheme.main,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 내가 추가한 할 일 리스트
            Container(
              decoration: BoxDecoration(
                color: doitColorTheme.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: doitColorTheme.shadow2.withOpacity(0.2),
                    blurRadius: 16,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  state.todoList.length,
                  (int index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (index != 0) const Divider(height: 12),
                      TodoListItemWidget(
                        model: state.todoList[index],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }
}
