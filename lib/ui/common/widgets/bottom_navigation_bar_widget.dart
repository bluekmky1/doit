import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../consts/assets.dart';

class BottomNavigationBarWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarWidget({
    required this.currentRouteName,
    super.key,
  });

  final String currentRouteName;

  @override
  ConsumerState<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 27, horizontal: 55),
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: doitColorTheme.shadow1.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          BottomNavigationBarItemWidget(
            label: '운세',
            selectedAsset: Assets.fortuneColored,
            unselectedAsset: Assets.fortuneFilled,
            isSelected: widget.currentRouteName == Routes.fortune.name,
            onTap: () {
              context.goNamed(Routes.fortune.name);
            },
          ),
          BottomNavigationBarItemWidget(
            label: '홈',
            selectedAsset: Assets.homeColored,
            unselectedAsset: Assets.homeOutlined,
            isSelected: widget.currentRouteName == Routes.home.name,
            onTap: () {
              context.goNamed(Routes.home.name);
            },
          ),
          BottomNavigationBarItemWidget(
            label: 'MY',
            selectedAsset: Assets.profileColored,
            unselectedAsset: Assets.profileOutlined,
            isSelected: widget.currentRouteName == Routes.my.name,
            onTap: () {
              context.goNamed(Routes.my.name);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBarItemWidget extends StatelessWidget {
  const BottomNavigationBarItemWidget({
    required this.label,
    required this.selectedAsset,
    required this.unselectedAsset,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final String selectedAsset;
  final String unselectedAsset;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                isSelected ? selectedAsset : unselectedAsset,
              ),
              Text(
                label,
                style: DoitTypos.suitSB12.copyWith(
                  color:
                      isSelected ? doitColorTheme.main : doitColorTheme.gray20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
