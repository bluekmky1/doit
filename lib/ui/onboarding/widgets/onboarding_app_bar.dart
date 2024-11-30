import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/doit_color_theme.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppBar({
    required this.pageController,
    super.key,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return AppBar(
      backgroundColor: doitColorTheme.background,
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: SmoothPageIndicator(
            controller: pageController,
            count: 4,
            effect: ExpandingDotsEffect(
              dotColor: doitColorTheme.gray20,
              activeDotColor: doitColorTheme.main,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 2,
              spacing: 4,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
