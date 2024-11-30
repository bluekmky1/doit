import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';

class GoalSuggestionWidget extends ConsumerWidget {
  final String title;

  final bool isChecked;
  final VoidCallback onPressedCheck;

  const GoalSuggestionWidget({
    required this.title,
    required this.isChecked,
    required this.onPressedCheck,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return GestureDetector(
      onTap: onPressedCheck,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.fromLTRB(
          16,
          14,
          16,
          14,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 10.0,
              color: doitColorTheme.shadow2.withOpacity(0.2),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: DoitTypos.suitSB16.copyWith(color: doitColorTheme.main),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.only(bottom: 21),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: isChecked ? doitColorTheme.main : doitColorTheme.gray20,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: doitColorTheme.main.withOpacity(0.2),
                  onTap: onPressedCheck,
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
      ),
    );
  }
}
