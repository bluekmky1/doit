import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/doit_color_theme.dart';
import '../../common/consts/assets.dart';

class TodoListItemWidget extends StatelessWidget {
  const TodoListItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              onLongPress: () {},
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Text('할일 이름'),
              ),
            ),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(left: 16),
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
    );
  }
}
