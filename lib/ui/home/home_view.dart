import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../domain/todo/model/todo_model.dart';
import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/assets.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import '../farm/game/farm_game.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/calender_bar_widget.dart';
import 'widgets/todo_list_item_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController mainAxisScrollController = ScrollController();
  final TextEditingController addTodoTextEditingController =
      TextEditingController();

  late FarmGame _farmGame;

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
    _farmGame = FarmGame();
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
    final List<String> lottiePaths = <String>[
      Assets.noShadowMouseMove,
      Assets.noShadowCowMove,
      Assets.noShadowTigerMove,
      Assets.noShadowRabbitMove,
      Assets.noShadowDragonMove,
      Assets.noShadowSnakeMove,
      Assets.noShadowChickenMove,
      Assets.noShadowPigMove,
      Assets.noShadowSheepMove,
      Assets.noShadowHorseMove,
      Assets.noShadowDogMove,
      Assets.noShadowMonkeyMove,
    ];

    final HomeState state = ref.watch(homeViewModelProvider);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final Size size = MediaQuery.of(context).size;
    final double gameHeight = MediaQuery.of(context).size.width / 375 * 218;
    FarmGame.screenSize = Vector2(size.width, gameHeight);

    ref.listen(
        homeViewModelProvider.select((HomeState state) => state.todoList),
        (List<TodoModel>? prev, List<TodoModel> next) {
      if (prev != null && prev.length < next.length) {
        // 랜덤한 위치에 새로운 MovableObject 추가
        final math.Random random = math.Random();
        final Vector2 position = Vector2(
          random.nextDouble() * FarmGame.screenSize.x,
          random.nextDouble() * FarmGame.screenSize.y,
        );
        _farmGame.world.add(MovableObject(
          position: position,
          lottiePath: lottiePaths[random.nextInt(lottiePaths.length)],
        ));
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Column(
                children: <Widget>[
                  // 게임
                  Stack(
                    children: <Widget>[
                      Container(
                        color: const Color(0xFF27358C),
                        height: gameHeight,
                        child: GameWidget<FarmGame>(
                          game: _farmGame,
                          backgroundBuilder: (BuildContext context) =>
                              Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Assets.gameBackground),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          loadingBuilder: (BuildContext context) =>
                              const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorBuilder: (BuildContext context, Object error) =>
                              Center(
                            child: Text('Error: $error'),
                          ),
                        ),
                      ),
                      // 농장으로 가기 버튼
                      Positioned(
                        right: 16,
                        bottom: 8,
                        child: IconButton(
                          onPressed: () {
                            context.pushNamed(Routes.farm.name);
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: doitColorTheme.background,
                          ),
                          icon: SvgPicture.asset(Assets.pawColored),
                        ),
                      ),
                    ],
                  ),
                  // 캘린더 바
                  const CalenderBarWidget(),
                ],
              ),
            ),
            // 투두 리스트 ----------------------------------
            const GoalExistTodoWidget(),

            const SizedBox(height: 140),
          ],
        ),
      ),
    );
  }
}

class GoalExistTodoWidget extends ConsumerStatefulWidget {
  const GoalExistTodoWidget({
    super.key,
  });

  @override
  ConsumerState<GoalExistTodoWidget> createState() =>
      _GoalExistTodoWidgetState();
}

class _GoalExistTodoWidgetState extends ConsumerState<GoalExistTodoWidget> {
  final TextEditingController addTodoTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Column(
      children: <Widget>[
        //  내가 추가한 할 일
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
          child: Row(
            children: <Widget>[
              SizedBox(
                child: SvgPicture.asset(
                  Assets.done,
                  width: 36,
                  height: 36,
                  colorFilter:
                      ColorFilter.mode(doitColorTheme.main, BlendMode.srcIn),
                ),
              ),
              const Text(
                '할 일 목록',
                style: DoitTypos.suitSB16,
              ),
              const Spacer(),
              IconButton(
                constraints: const BoxConstraints(),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  viewModel.setIsAddingTodo(value: true);
                },
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
        if (state.isAddingTodo)
          Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: addTodoTextEditingController,
                    autofocus: true,
                    onTapOutside: (PointerDownEvent event) {
                      FocusScope.of(context).unfocus();
                      viewModel.setIsAddingTodo(value: false);
                      if (addTodoTextEditingController.text.isNotEmpty) {
                        viewModel.addTodo(
                          todo: addTodoTextEditingController.text,
                        );
                      }
                      addTodoTextEditingController.clear();
                    },
                    onSubmitted: (String value) {
                      FocusScope.of(context).unfocus();
                      viewModel.setIsAddingTodo(value: false);
                      if (addTodoTextEditingController.text.isNotEmpty) {
                        viewModel.addTodo(
                          todo: addTodoTextEditingController.text,
                        );
                      }
                      addTodoTextEditingController.clear();
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: '여기에 할 일을 적어보세요!',
                      hintStyle: DoitTypos.suitR14,
                    ),
                    cursorHeight: 20,
                    style: DoitTypos.suitR14,
                    cursorColor: doitColorTheme.main,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...List<Widget>.generate(
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
            ],
          ),
        ),
      ],
    );
  }
}
