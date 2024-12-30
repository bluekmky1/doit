import 'dart:async';
import 'dart:math' as math;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/doit_color_theme.dart';

import '../common/consts/assets.dart';
import 'farm_state.dart';
import 'farm_view_model.dart';
import 'game/farm_game.dart';
import 'widgets/animal_status_bar_widget.dart';
import 'widgets/bottom_menu_bar_widget.dart';
import 'widgets/clock_widget.dart';

class FarmView extends ConsumerStatefulWidget {
  const FarmView({super.key});

  @override
  ConsumerState<FarmView> createState() => _FarmViewState();
}

class _FarmViewState extends ConsumerState<FarmView>
    with WidgetsBindingObserver {
  late FarmGame _farmGame;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _farmGame = FarmGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Size size = MediaQuery.of(context).size;
    FarmGame.screenSize = Vector2(size.width, size.height);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final FarmState state = ref.watch(farmViewModelProvider);
    final DoitColorTheme doitColorTheme =
        Theme.of(context).extension<DoitColorTheme>()!;
    final List<String> lottiePaths = <String>[
      Assets.noShadowMouseMove,
      Assets.noShadowCowMove,
      Assets.noShadowTigerMove,
      Assets.noShadowRabbitMove,
      Assets.noShadowDragonMove,
      Assets.noShadowSnakeMove,
      Assets.noShadowChickenMove,
      Assets.noShadowPigMove,
      Assets.noShadowSheepMove,
      Assets.noShadowHorseMove,
      Assets.noShadowDogMove,
      Assets.noShadowMonkeyMove,
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: isLandscape ? Alignment.center : Alignment.centerLeft,
          children: <Widget>[
            GameWidget<FarmGame>(
              game: _farmGame,
              backgroundBuilder: (BuildContext context) => Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.farmBackgroundLandscape),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              loadingBuilder: (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorBuilder: (BuildContext context, Object error) => Center(
                child: Text('Error: $error'),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: isLandscape
                  ? MediaQuery.of(context).size.height * 0.07
                  : MediaQuery.of(context).size.height * 0.15,
              bottom: isLandscape ? 0 : null,
              child: const ClockWidget(),
            ),
            Positioned(
              left: 0,
              top: isLandscape ? 0 : 20,
              right: isLandscape ? 0 : null,
              child: AnimatedOpacity(
                opacity: state.isAnimalButtonSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  offset: isLandscape
                      ? Offset(0.0, state.isAnimalButtonSelected ? 0.0 : -1.0)
                      : Offset(state.isAnimalButtonSelected ? 0.0 : -1.0, 0.0),
                  child: AnimalStatusBarWidget(
                    data: List<AnimalStatus>.generate(
                        12,
                        (int index) => AnimalStatus(
                              count: '100',
                              animalAssetPath: Assets.allLuck,
                            )),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const BottomMenuBarWidget(),
      ),
    );
  }
}
