import 'package:flutter/material.dart';

import '../../../theme/doit_color_theme.dart';

class ElevatedCardWidget extends StatelessWidget {
  const ElevatedCardWidget({
    required this.child,
    this.width = double.infinity,
    this.height,
    super.key,
  });

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: doitColorTheme.shadow2.withOpacity(0.2),
            blurRadius: 10,
          )
        ],
        borderRadius: BorderRadius.circular(16),
        color: doitColorTheme.background,
      ),
      child: child,
    );
  }
}
