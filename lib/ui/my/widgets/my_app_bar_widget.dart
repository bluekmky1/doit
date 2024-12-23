import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/widgets/text_chip_widget.dart';

class MyAppBarWidget extends StatelessWidget {
  const MyAppBarWidget({
    required this.doitColorTheme,
    super.key,
  });

  final DoitColorTheme doitColorTheme;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 52, 0, 18),
        child: Row(
          children: <Widget>[
            Text(
              '마재훈',
              style: DoitTypos.suitSB20.copyWith(
                color: doitColorTheme.main,
              ),
            ),
            const SizedBox(width: 16),
            const Wrap(
              spacing: 8,
              children: <Widget>[
                TextChipWidget(
                  title: '2000.05.23',
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                ),
                TextChipWidget(
                  title: '09:30 생',
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                ),
                TextChipWidget(
                  title: '남성',
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.edit,
                colorFilter: ColorFilter.mode(
                  doitColorTheme.gray80,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      );
}
