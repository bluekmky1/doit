import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';

class TextChipWidget extends StatelessWidget {
  const TextChipWidget({
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    super.key,
  });

  final String title;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return Container(
      height: 24,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(100),
        color: doitColorTheme.gray10,
      ),
      child: Text(
        title,
        style: DoitTypos.suitR12.copyWith(
          color: doitColorTheme.gray80,
        ),
      ),
    );
  }
}
