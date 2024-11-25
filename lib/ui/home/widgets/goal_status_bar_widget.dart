import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

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
                onPressed: () {},
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
