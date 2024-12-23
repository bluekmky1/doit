import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/todo/model/recommended_todo_model.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../fortune_state.dart';
import '../fortune_view_model.dart';

class CardSliderWidget extends ConsumerStatefulWidget {
  const CardSliderWidget({super.key});

  @override
  ConsumerState<CardSliderWidget> createState() => _CardSliderWidgetState();
}

class _CardSliderWidgetState extends ConsumerState<CardSliderWidget> {
  final PageController cardCarouselController =
      PageController(viewportFraction: 300 / 375);

  @override
  Widget build(BuildContext context) {
    final FortuneState state = ref.watch(fortuneViewModelProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Column(
      children: <Widget>[
        SizedBox(
          width: screenWidth,
          height: 232,
          child: PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: cardCarouselController,
            itemCount: state.recommendedTodoList.length,
            itemBuilder: (BuildContext context, int index) => _AnimatedCard(
              model: state.recommendedTodoList[index],
            ),
          ),
        ),
        if (state.recommendedTodoList.isNotEmpty)
          SmoothPageIndicator(
            controller: cardCarouselController,
            count: state.recommendedTodoList.length,
            effect: ExpandingDotsEffect(
              dotColor: doitColorTheme.gray20,
              activeDotColor: doitColorTheme.main,
              dotHeight: 4,
              dotWidth: 4,
              expansionFactor: 2,
              spacing: 2,
            ),
          ),
      ],
    );
  }
}

class _AnimatedCard extends ConsumerWidget {
  final RecommendedTodoModel model;

  const _AnimatedCard({
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Container(
      margin: const EdgeInsets.only(right: 16, bottom: 16, top: 16),
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 16,
            spreadRadius: 1,
            color: doitColorTheme.shadow2.withOpacity(0.15),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  // 40 자까지 적을 수 있음
                  child: Text(
                    model.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: DoitTypos.suitSB16,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              SvgPicture.asset(
                fortuneIconPath,
                colorFilter: ColorFilter.mode(
                  doitColorTheme.main,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                // 23 자까지 적을 수 있음
                child: Text(
                  '${model.fortune}이 상승하는 할 일입니다.',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: DoitTypos.suitR12,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: -50,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset(
                            fortuneImagePath,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(bottom: 21),
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: model.isDone
                        ? doitColorTheme.main
                        : doitColorTheme.gray20,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: doitColorTheme.main.withOpacity(0.2),
                      onTap: () {},
                      child: SvgPicture.asset(
                        Assets.add,
                        colorFilter: ColorFilter.mode(
                          doitColorTheme.background,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String get fortuneIconPath {
    if (model.fortune == '연애운') {
      return Assets.heartOutlined;
    }
    if (model.fortune == '금전운') {
      return Assets.pigOutlined;
    }
    if (model.fortune == '학업운') {
      return Assets.bookOutlined;
    }
    return Assets.puzzle;
  }

  String get fortuneImagePath {
    if (model.fortune == '연애운') {
      return Assets.love;
    }
    if (model.fortune == '금전운') {
      return Assets.money;
    }
    if (model.fortune == '학업운') {
      return Assets.study;
    }
    return Assets.allLuck;
  }
}
