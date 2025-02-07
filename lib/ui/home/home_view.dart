import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/loading_status.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/animal_type.dart';
import '../common/consts/assets.dart';
import '../common/game/farm_game.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'home_state.dart';
import 'home_view_model.dart';
import 'widgets/calender_bar_widget.dart';
import 'widgets/routine_list_item_widget.dart';
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

  // 스크롤이 맨 위(0.99)까지 갔을 때 1으로 이동
  void _scrollListener() {
    if (mainAxisScrollController.offset <= 0.000009) {
      mainAxisScrollController.jumpTo(0.000009);
    }
  }

  @override
  void initState() {
    super.initState();
    _farmGame = FarmGame();
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

  Vector2 _getRandomPosition() {
    final math.Random random = math.Random();
    return Vector2(
      random.nextDouble() * FarmGame.screenSize.x,
      random.nextDouble() * FarmGame.screenSize.y,
    );
  }

  void _initAnimalsToGame() {
    final HomeState state = ref.read(homeViewModelProvider);
    for (final TodoModel todo
        in state.todoList.where((TodoModel todo) => !todo.isCompleted)) {
      _farmGame.world.add(
        MovableObject(
          id: todo.todoId,
          position: _getRandomPosition(),
          animalType: AnimalType.fromString(todo.animalName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);

    // 할 일 목록 로드 완료 시 게임 월드에 동물 추가
    ref.listen(
      homeViewModelProvider
          .select((HomeState state) => state.getTodoListLoadingStatus),
      (Object? prev, Object? next) {
        if (next == LoadingStatus.success) {
          // 게임 월드에 있는 모든 동물 제거
          _farmGame.world
              .removeWhere((Component component) => component is MovableObject);

          // 게임 월드에 동물 추가
          _initAnimalsToGame();
        }
      },
    );

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final Size size = MediaQuery.of(context).size;
    final double gameHeight = MediaQuery.of(context).size.width / 375 * 218;
    _farmGame.viewSize = Vector2(size.width, gameHeight);

    // 선택된 날짜의 할 일 추가 시 게임 월드에 동물 추가
    ref
      ..listen(
        homeViewModelProvider
            .select((HomeState state) => state.lastAddedTodoId),
        (String? prev, String next) {
          final HomeState newState = ref.read(homeViewModelProvider);
          final TodoModel addedTodo = newState.todoList.firstWhere(
            (TodoModel todo) => todo.todoId == next,
          );

          if (next.isNotEmpty && addedTodo.dueDate == newState.selectedDate) {
            _farmGame.world.add(MovableObject(
              id: addedTodo.todoId,
              position: _getRandomPosition(),
              animalType: AnimalType.fromString(
                addedTodo.animalName,
              ),
            ));
          }
        },
      )

      // 선택된 날짜의 할 일 제거 시 게임 월드에 있는 동물 제거
      ..listen(
        homeViewModelProvider
            .select((HomeState state) => state.lastDeletedTodoId),
        (String? prev, String next) {
          _farmGame.world.removeWhere((Component component) =>
              component is MovableObject && component.id == next);
        },
      )

      // 할 일 완료 상태 변경 시 게임 월드의 동물 추가/제거
      ..listen(
        homeViewModelProvider
            .select((HomeState state) => state.toggleTodoDoneLoadingStatus),
        (LoadingStatus? prev, LoadingStatus next) {
          if (next == LoadingStatus.success) {
            final HomeState newState = ref.read(homeViewModelProvider);
            final TodoModel updatedTodo = newState.todoList.firstWhere(
              (TodoModel todo) => todo.todoId == newState.lastToggledTodoId,
            );
            if (updatedTodo.isCompleted) {
              // 완료된 경우: 동물 제거
              _farmGame.world.removeWhere((Component component) =>
                  component is MovableObject &&
                  component.id == updatedTodo.todoId);
            } else {
              // 완료 취소된 경우: 동물이 없을 때만 추가

              final bool animalExists = _farmGame.world.children.any(
                  (Component component) =>
                      component is MovableObject &&
                      component.id == updatedTodo.todoId);
              if (!animalExists &&
                  updatedTodo.dueDate == newState.selectedDate) {
                _farmGame.world.add(MovableObject(
                  id: updatedTodo.todoId,
                  position: _getRandomPosition(),
                  animalType: AnimalType.fromString(updatedTodo.animalName),
                ));
              }
            }
          }
        },
      );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.home.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        controller: mainAxisScrollController,
        // 스크롤 애니메이션 설정
        physics: const BouncingScrollPhysics(
          // 스크롤 감속 속도 설정
          decelerationRate: ScrollDecelerationRate.fast,
          parent: AlwaysScrollableScrollPhysics(),
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
                    ],
                  ),
                  // 캘린더 바
                  const CalenderBarWidget(),
                ],
              ),
            ),
            // 투두 리스트 섹션
            const TodoListSection(),
            // 루틴 리스트 섹션
            const RoutineListSection(),

            SizedBox(
              height: state.isAddingTodo
                  ? MediaQuery.of(context).viewInsets.bottom
                  : 140,
            ),
          ],
        ),
      ),
    );
  }
}

class TodoListSection extends ConsumerStatefulWidget {
  const TodoListSection({
    super.key,
  });

  @override
  ConsumerState<TodoListSection> createState() => _TodoListSectionState();
}

class _TodoListSectionState extends ConsumerState<TodoListSection> {
  final TextEditingController addTodoTextEditingController =
      TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final HomeState state = ref.watch(homeViewModelProvider);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Column(
      children: <Widget>[
        // 할 일 목록 헤더
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
          child: TodoListHeader(focusNode: _focusNode),
        ),
        // 할 일 추가 폼
        if (state.isAddingTodo)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: AddTodoForm(
              addTodoTextEditingController: addTodoTextEditingController,
              focusNode: _focusNode,
            ),
          ),
        // 비어 있는 공간
        // 할 일 목록이 비어있고 할 일 추가 폼이 없을 때 빈 공간 표시
        // 루틴 목록이 비어있을 때 빈 공간 표시
        if (state.isNotTodoLoading &&
            (state.todoList.isEmpty && !state.isAddingTodo) &&
            state.routineList.isEmpty)
          const EmptyTodoSpace(),

        // 내가 추가한 할 일 리스트
        // 할 일 목록이 비어있지 않고 할 일 목록 로드 완료 시 할 일 목록 리스트 표시
        if (state.todoList.isNotEmpty && state.isNotTodoLoading)
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

class AddTodoForm extends ConsumerWidget {
  const AddTodoForm({
    required this.addTodoTextEditingController,
    required FocusNode focusNode,
    super.key,
  }) : _focusNode = focusNode;

  final TextEditingController addTodoTextEditingController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
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
              focusNode: _focusNode,
              onTapOutside: (_) {
                viewModel.setIsAddingTodo(value: false);
                if (addTodoTextEditingController.text.isNotEmpty) {
                  viewModel.addTodo(
                    todo: addTodoTextEditingController.text.trim(),
                  );
                }
                addTodoTextEditingController.clear();
              },
              onSubmitted: (_) {
                viewModel.setIsAddingTodo(value: false);
                if (addTodoTextEditingController.text.isNotEmpty) {
                  viewModel.addTodo(
                    todo: addTodoTextEditingController.text.trim(),
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
    );
  }
}

class TodoListHeader extends ConsumerWidget {
  const TodoListHeader({
    required FocusNode focusNode,
    super.key,
  }) : _focusNode = focusNode;

  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final HomeState state = ref.watch(homeViewModelProvider);
    final HomeViewModel viewModel = ref.read(homeViewModelProvider.notifier);

    return Row(
      children: <Widget>[
        SizedBox(
          child: SvgPicture.asset(
            Assets.done,
            width: 36,
            height: 36,
            colorFilter: ColorFilter.mode(doitColorTheme.main, BlendMode.srcIn),
          ),
        ),
        const Text(
          '할 일 목록',
          style: DoitTypos.suitSB16,
        ),
        const Spacer(),
        if (state.isNotTodoLoading)
          // 할 일 추가 버튼
          IconButton(
            constraints: const BoxConstraints(),
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              viewModel.setIsAddingTodo(value: true);
              _focusNode.requestFocus();

              Future<void>.delayed(const Duration(milliseconds: 400), () {
                if (context.mounted) {
                  Scrollable.ensureVisible(
                    context,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              });
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
    );
  }
}

class EmptyTodoSpace extends StatelessWidget {
  const EmptyTodoSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Image.asset(Assets.emptyDragon),
          const SizedBox(height: 10),
          const Text(
            '등록한 할 일이 없어요\n'
            '할 일을 추가해보세요!',
            style: DoitTypos.suitR14,
            textAlign: TextAlign.center,
          ),
        ],
      );
}

class RoutineListSection extends ConsumerStatefulWidget {
  const RoutineListSection({
    super.key,
  });

  @override
  ConsumerState<RoutineListSection> createState() => _RoutineListSectionState();
}

class _RoutineListSectionState extends ConsumerState<RoutineListSection> {
  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final HomeState state = ref.watch(homeViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 투두 리스트가 있을 경우
        if (state.todoList.isNotEmpty) const SizedBox(height: 16),

        // 루틴 리스트 로드 완료 시 루틴 리스트 컨테이너 표시
        if (state.getRoutineListLoadingStatus == LoadingStatus.success &&
            state.getTodoListLoadingStatus == LoadingStatus.success)
          Container(
            decoration: BoxDecoration(
              color: doitColorTheme.background,
              borderRadius: BorderRadius.circular(16),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: doitColorTheme.shadow2.withOpacity(0.15),
                  blurRadius: 16,
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...List<Widget>.generate(
                  state.routineList.length,
                  (int index) {
                    // 먼저 보여질 루틴들의 인덱스를 찾습니다
                    final List<int> visibleIndices = List<int>.generate(
                      state.routineList.length,
                      (int index) => index,
                    ).where((int index) {
                      final String routineId = state.routineList[index].id;
                      return !state.todoList
                          .any((TodoModel todo) => todo.routineId == routineId);
                    }).toList();
                    // 현재 루틴의 ID로 todo 검색
                    final String currentRoutineId = state.routineList[index].id;
                    final bool hasTodo = state.todoList.any(
                      (TodoModel todo) => todo.routineId == currentRoutineId,
                    );

                    // 투두가 있는 경우 표시하지 않음
                    if (hasTodo) {
                      return const SizedBox.shrink();
                    }

                    // 현재 보이는 루틴들 중에서 이 루틴의 위치를 찾음
                    final int currentVisibleIndex =
                        visibleIndices.indexOf(index);
                    final bool showDivider = currentVisibleIndex != -1 &&
                        currentVisibleIndex < visibleIndices.length - 1;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RoutineListItemWidget(
                          id: state.routineList[index].id,
                          title: state.routineList[index].title,
                        ),
                        if (showDivider)
                          const Divider(
                            height: 12,
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
