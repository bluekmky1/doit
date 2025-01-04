import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/doit_color_theme.dart';
import '../../../theme/doit_typos.dart';
import '../../common/consts/assets.dart';
import '../../common/game/farm_game.dart';
import '../farm_state.dart';
import '../farm_view_model.dart';

class BottomMenuBarWidget extends ConsumerStatefulWidget {
  const BottomMenuBarWidget({super.key});

  @override
  ConsumerState<BottomMenuBarWidget> createState() =>
      _BottomMenuBarWidgetState();
}

class _BottomMenuBarWidgetState extends ConsumerState<BottomMenuBarWidget> {
  @override
  Widget build(BuildContext context) {
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final FarmState state = ref.watch(farmViewModelProvider);
    final FarmViewModel viewModel = ref.watch(farmViewModelProvider.notifier);
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 375,
      ),
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
            label: '나가기',
            selectedAsset: Assets.closeMD,
            unselectedAsset: Assets.closeMD,
            isSelected: true,
            onTap: () {
              // TODO(jaehoon): 나중에 더 좋은 방법이 있다면 변경
              final Size size = MediaQuery.of(context).size;
              final double gameHeight = size.width / 375 * 218;
              FarmGame.screenSize = Vector2(size.width, gameHeight);
              context.pop();
            },
          ),
          BottomNavigationBarItemWidget(
            label: '동물들',
            selectedAsset: Assets.animalColored,
            unselectedAsset: Assets.animalFilled,
            isSelected: state.isAnimalButtonSelected,
            onTap: viewModel.setIsAnimalButtonSelected,
          ),
          BottomNavigationBarItemWidget(
            label: '시계',
            selectedAsset: Assets.clockColored,
            unselectedAsset: Assets.clockFilled,
            isSelected: state.isClockButtonSelected,
            onTap: viewModel.setIsClockButtonSelected,
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
              if (label == '나가기')
                SvgPicture.asset(
                  Assets.closeMD,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    doitColorTheme.main,
                    BlendMode.srcIn,
                  ),
                )
              else
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
