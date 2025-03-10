import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

class FortuneScoreGageWidget extends StatelessWidget {
  final String title;
  final int score;

  const FortuneScoreGageWidget({
    required this.title,
    required this.score,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.5, vertical: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 6.5),
              Text(
                '$title 지수',
                style: DoitTypos.suitR12,
              ),
              const SizedBox(width: 8),
              Text(
                score.toString(),
                style: DoitTypos.suitSB16.copyWith(color: doitColorTheme.main),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: doitColorTheme.gray10,
                      ),
                      height: 16,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: <Color>[
                              doitColorTheme.gradient1Stop42,
                              doitColorTheme.gradient1Stop100.withOpacity(0.7),
                            ]),
                      ),
                      width: (MediaQuery.of(context).size.width - 47) /
                          100 *
                          score,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
