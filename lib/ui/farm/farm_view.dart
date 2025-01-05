import 'dart:async';
import 'dart:math' as math;

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../common/consts/animal_type.dart';
import '../common/consts/assets.dart';
import '../common/game/farm_game.dart';
import 'farm_state.dart';
import 'farm_view_model.dart';
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
  Timer? _timer;
  late FarmGame _farmGame;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(farmViewModelProvider.notifier).getThisMonthTodoList();
    });
    _farmGame = FarmGame();

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Size size = MediaQuery.of(context).size;
    FarmGame.screenSize = Vector2(size.width, size.height);
  }

  Vector2 _getRandomPosition() {
    final math.Random random = math.Random();
    return Vector2(
      random.nextDouble() * FarmGame.screenSize.x,
      random.nextDouble() * FarmGame.screenSize.y,
    );
  }

  void _initAnimalsToGame() {
    final FarmState state = ref.read(farmViewModelProvider);
    for (final AnimalMarkerModel animal in state.animalList) {
      final AnimalType animalType = AnimalType.fromString(animal.name);
      for (int i = 0; i < animal.count; i++) {
        _farmGame.world.add(
          MovableObject(
            id: '${animal.name}_$i',
            position: _getRandomPosition(),
            animalType: animalType,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final FarmState state = ref.watch(farmViewModelProvider);

    ref.listen(
        farmViewModelProvider
            .select((FarmState state) => state.getTodoListLoadingStatus),
        (LoadingStatus? prev, LoadingStatus next) {
      if (next == LoadingStatus.success) {
        _initAnimalsToGame();
      }
    });

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
                  child: const AnimalStatusBarWidget(),
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
