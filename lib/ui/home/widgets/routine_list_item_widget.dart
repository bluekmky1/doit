import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/doit_color_theme.dart';
import '../../common/consts/assets.dart';

class RoutineListItemWidget extends ConsumerWidget {
  const RoutineListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Row(
      children: <Widget>[
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('루틴 아이템'),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: doitColorTheme.gray20,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              overlayColor: WidgetStatePropertyAll<Color>(
                doitColorTheme.main.withOpacity(0.2),
              ),
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
    );
  }
}
