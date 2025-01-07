import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../../routes/routes.dart';
import '../../theme/doit_color_theme.dart';
import '../../theme/doit_typos.dart';
import '../common/consts/animal_type.dart';
import '../common/widgets/accordion_card_widget.dart';
import '../common/widgets/bottom_navigation_bar_widget.dart';
import '../common/widgets/text_chip_widget.dart';
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              // 앱바

              if (state.getUserDataLoadingStatus == LoadingStatus.success)
                const MyAppBarWidget()
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 52, 0, 72),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          color: doitColorTheme.main,
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
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
              ),
              const SizedBox(height: 16),
              if (state.getUserDataLoadingStatus == LoadingStatus.success)
                _CompletedTodoCardWidget(
                  count: state.completedTodoCount.toString(),
                  animalMarkerList: state.animalMarkerList,
                )
              else
                const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletedTodoCardWidget extends StatelessWidget {
  const _CompletedTodoCardWidget({
    required this.count,
    required this.animalMarkerList,
  });

  final String count;
  final List<AnimalMarkerModel> animalMarkerList;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String year = now.year.toString();
    final String month = now.month.toString();

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
                '$year년 $month월',
                style: DoitTypos.suitR14.copyWith(
                  color: doitColorTheme.gray60,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: TextChipWidget(
                  title: '$count마리',
                  padding: const EdgeInsets.symmetric(horizontal: 8),
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
                              animalMarkerList[index].count.toString().length >
                                      3
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

          // TODOS(재훈): 월 별 농장으로 이동하는 버튼 추가 기획 필요
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
