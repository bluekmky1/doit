import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

class FortuneAppBarWidget extends StatelessWidget {
  const FortuneAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 52, bottom: 20, left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '오늘의 운세',
            style: DoitTypos.suitSB20.copyWith(
              color: doitColorTheme.main,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '''${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}''',
            style: DoitTypos.suitR14.copyWith(height: 2.0),
          ),
        ],
      ),
    );
  }
}
