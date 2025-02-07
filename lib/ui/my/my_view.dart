import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/animal_type.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import 'my_state.dart';
import 'my_view_model.dart';
import 'widgets/my_app_bar_widget.dart';

class MyView extends ConsumerStatefulWidget {
  const MyView({super.key});

  @override
  ConsumerState<MyView> createState() => _MyViewState();
}

class _MyViewState extends ConsumerState<MyView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final MyState state = ref.watch(myViewModelProvider);
    return Scaffold(
      floatingActionButton: BottomNavigationBarWidget(
        currentRouteName: Routes.my.name,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: MyAppBarWidget(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CollectedAnimalsHeader(),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: _CompletedTodoCardWidget(),
                ),
                if (state.getUserDataLoadingStatus == LoadingStatus.success)
                  Container(
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 4,
                          color: doitColorTheme.gray20,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                if (state.getUserDataLoadingStatus == LoadingStatus.success)
                  _RouteItem(
                    onTap: () {
                      context.pushNamed(Routes.routine.name);
                    },
                    title: '루틴 관리',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CollectedAnimalsHeader extends ConsumerWidget {
  const CollectedAnimalsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MyState state = ref.watch(myViewModelProvider);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    if (state.getUserDataLoadingStatus == LoadingStatus.loading) {
      return Shimmer.fromColors(
        baseColor: doitColorTheme.gray10,
        highlightColor: doitColorTheme.gray20,
        child: Container(
          width: 120,
          height: 24,
          decoration: BoxDecoration(
            color: doitColorTheme.gray20,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          '이번달에 모은 동물들',
          style: DoitTypos.suitSB16,
        ),
        SizedBox(
          height: 32,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              backgroundColor: doitColorTheme.main,
              foregroundColor: doitColorTheme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.61),
              ),
            ),
            onPressed: () {
              context.pushNamed(Routes.farm.name);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '보러가기',
                  style: DoitTypos.suitR14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompletedTodoCardWidget extends ConsumerWidget {
  const _CompletedTodoCardWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridItemSpacing = screenWidth / 375 * 12;
    final double gridItemRunSpacing = screenWidth / 375 * 16;

    final MyState state = ref.watch(myViewModelProvider);

    final List<AnimalMarkerModel> animalMarkerList = state.animalMarkerList;

    if (state.getUserDataLoadingStatus == LoadingStatus.loading) {
      return Shimmer.fromColors(
        baseColor: doitColorTheme.gray10,
        highlightColor: doitColorTheme.gray20,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: doitColorTheme.gray20,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    return Column(
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
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: animalMarkerList[index].count.toString().length > 3
                        ? 4
                        : 12,
                    child: Text(animalMarkerList[index].count.toString(),
                        style:
                            animalMarkerList[index].count.toString().length > 3
                                ? DoitTypos.suitSB12
                                : DoitTypos.suitSB16),
                  ),
                  Positioned(
                    left: 34,
                    child: SizedBox(
                      height: constraints.maxHeight * 1.0,
                      child: Image.asset(
                        AnimalType.fromString(animalMarkerList[index].name)
                            .horizontalMarkPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RouteItem extends ConsumerWidget {
  const _RouteItem({
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: DoitTypos.suitSB16,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: doitColorTheme.gray60,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
