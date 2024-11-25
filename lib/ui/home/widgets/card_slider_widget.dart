import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';

class CardSliderWidget extends StatefulWidget {
  const CardSliderWidget({super.key});

  @override
  State<CardSliderWidget> createState() => _CardSliderWidgetState();
}

class _CardSliderWidgetState extends State<CardSliderWidget> {
  final PageController cardCarouselController =
      PageController(viewportFraction: 300 / 375);

  @override
  Widget build(BuildContext context) {
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
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) =>
                const _AnimatedCard(
              title: '제목1',
              comment: '내용이 길 경우 줄바꿈이 되어야 합니다.',
              iconPath: Assets.pigOutlined,
              done: false,
            ),
          ),
        ),
        SmoothPageIndicator(
          controller: cardCarouselController,
          count: 3,
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

class _AnimatedCard extends StatelessWidget {
  final String title;
  final String comment;
  final String iconPath;
  final bool done;

  const _AnimatedCard({
    required this.title,
    required this.comment,
    required this.iconPath,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
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
                    title,
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
                iconPath,
                colorFilter: ColorFilter.mode(
                  doitColorTheme.main,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                // 23 자까지 적을 수 있음
                child: Text(
                  comment,
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
                            Assets.money,
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
                    color: done ? doitColorTheme.main : doitColorTheme.gray20,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: doitColorTheme.main.withOpacity(0.2),
                      onTap: () {},
                      child: SvgPicture.asset(
                        Assets.done,
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
}
