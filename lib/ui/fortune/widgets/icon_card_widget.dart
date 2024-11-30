import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/fortune_category.dart';
import '../fortune_view_model.dart';

class IconCardListWidget extends ConsumerWidget {
  const IconCardListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ...FortuneCategory.values.map(
              (FortuneCategory category) => IconCardWidget(
                category: category,
              ),
            ),
          ],
        ),
      );
}

class IconCardWidget extends ConsumerWidget {
  const IconCardWidget({
    required this.category,
    super.key,
  });

  final FortuneCategory category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FortuneViewModel viewModel =
        ref.read(fortuneViewModelProvider.notifier);

    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    final bool selected =
        ref.watch(fortuneViewModelProvider).selectedFortuneCategory == category;

    return GestureDetector(
      onTap: () {
        viewModel.selectFortuneCategory(
          fortuneCategory: category,
        );
      },
      child: Container(
        width: 50,
        height: 70,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: selected
                ? const <double>[
                    0.42,
                    1,
                  ]
                : <double>[0],
            colors: selected
                ? <Color>[
                    doitColorTheme.gradient1Stop42,
                    doitColorTheme.gradient1Stop100.withOpacity(0.7),
                  ]
                : <Color>[
                    Colors.transparent,
                  ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                selected ? doitColorTheme.gray10 : doitColorTheme.gray20,
                BlendMode.srcIn,
              ),
              selected
                  ? category.selectedIconName
                  : category.unselectedIconName,
              width: 40,
              height: 40,
            ),
            Text(
              category.title,
              style: DoitTypos.suitR12.copyWith(
                color: selected
                    ? doitColorTheme.background
                    : doitColorTheme.gray60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
