import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../theme/doit_color_theme.dart';

class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OnboardingAppBar({
    required this.pageController,
    required this.isFirstPage,
    super.key,
  });

  final PageController pageController;
  final bool isFirstPage;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;

    return AppBar(
      backgroundColor: doitColorTheme.background,
      leading: isFirstPage
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
      scrolledUnderElevation: 0,
      elevation: 0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: SmoothPageIndicator(
            controller: pageController,
            count: 2,
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
