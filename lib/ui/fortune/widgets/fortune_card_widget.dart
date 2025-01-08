import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/widgets/elevated_card_widget.dart';

class FortuneCardWidget extends StatelessWidget {
  final String? title;
  final String? shortFortune;
  final String fullFortune;
  const FortuneCardWidget({
    required this.fullFortune,
    this.title,
    this.shortFortune,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ElevatedCardWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (shortFortune != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  shortFortune ?? '',
                  style: DoitTypos.suitSB16.copyWith(
                    color: doitColorTheme.main,
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ),
            Text(
              fullFortune,
              style: DoitTypos.suitR14.copyWith(
                color: doitColorTheme.gray80,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
