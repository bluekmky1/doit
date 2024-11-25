import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';

class GoalStatusBarWidget extends StatelessWidget {
  const GoalStatusBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.transparent,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: doitColorTheme.shadow1.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      height: 82,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text(
                '마재훈님의 목표',
                style: DoitTypos.suitR16,
              ),
              const SizedBox(width: 16),
              const Text(
                '2024.11.25 - 2024.12.01',
                style: DoitTypos.suitR12,
              ),
              const Spacer(),
              IconButton(
                constraints: const BoxConstraints(),
                style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        const GoalDetailModalWidget(),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            '한 달 안에 긍정적인 사람 되어보기',
            style: DoitTypos.suitSB20,
          ),
        ],
      ),
    );
  }
}

class GoalDetailModalWidget extends StatelessWidget {
  const GoalDetailModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: doitColorTheme.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                '한 달 안에 긍정적인 사람 되어보기',
                style: DoitTypos.suitSB20,
              ),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: SvgPicture.asset(
                  Assets.closeMD,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.gray60,
                    BlendMode.srcIn,
                  ),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              overlayColor: doitColorTheme.gray80,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.goal,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.main,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '목표 조기 달성',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.main,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: doitColorTheme.gray20,
            height: 29,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              overlayColor: doitColorTheme.gray80,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.calendar,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.gray80,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '기간 연장하기',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.gray80,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: doitColorTheme.gray20,
            height: 29,
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              overlayColor: doitColorTheme.gray80,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.delete,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.error,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '목표 포기하기',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.error,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
