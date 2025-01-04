import 'assets.dart';

enum AnimalType {
  mouse(
    name: 'mouse',
    movingLottiePath: Assets.noShadowMouseMove,
    stopLottiePath: Assets.noShadowMouseStop,
    horizontalMarkPath: Assets.mouseHorizontalMark,
  ),
  cow(
    name: 'cow',
    movingLottiePath: Assets.noShadowCowMove,
    stopLottiePath: Assets.noShadowCowStop,
    horizontalMarkPath: Assets.cowHorizontalMark,
  ),
  tiger(
    name: 'tiger',
    movingLottiePath: Assets.noShadowTigerMove,
    stopLottiePath: Assets.noShadowTigerStop,
    horizontalMarkPath: Assets.tigerHorizontalMark,
  ),
  rabbit(
    name: 'rabbit',
    movingLottiePath: Assets.noShadowRabbitMove,
    stopLottiePath: Assets.noShadowRabbitStop,
    horizontalMarkPath: Assets.rabbitHorizontalMark,
  ),
  dragon(
    name: 'dragon',
    movingLottiePath: Assets.noShadowDragonMove,
    stopLottiePath: Assets.noShadowDragonStop,
    horizontalMarkPath: Assets.dragonHorizontalMark,
  ),
  snake(
    name: 'snake',
    movingLottiePath: Assets.noShadowSnakeMove,
    stopLottiePath: Assets.noShadowSnakeStop,
    horizontalMarkPath: Assets.snakeHorizontalMark,
  ),
  horse(
    name: 'horse',
    movingLottiePath: Assets.noShadowHorseMove,
    stopLottiePath: Assets.noShadowHorseStop,
    horizontalMarkPath: Assets.horseHorizontalMark,
  ),
  sheep(
    name: 'sheep',
    movingLottiePath: Assets.noShadowSheepMove,
    stopLottiePath: Assets.noShadowSheepStop,
    horizontalMarkPath: Assets.sheepHorizontalMark,
  ),
  monkey(
    name: 'monkey',
    movingLottiePath: Assets.noShadowMonkeyMove,
    stopLottiePath: Assets.noShadowMonkeyStop,
    horizontalMarkPath: Assets.monkeyHorizontalMark,
  ),
  chicken(
    name: 'chicken',
    movingLottiePath: Assets.noShadowChickenMove,
    stopLottiePath: Assets.noShadowChickenStop,
    horizontalMarkPath: Assets.chickenHorizontalMark,
  ),
  dog(
    name: 'dog',
    movingLottiePath: Assets.noShadowDogMove,
    stopLottiePath: Assets.noShadowDogStop,
    horizontalMarkPath: Assets.dogHorizontalMark,
  ),
  pig(
    name: 'pig',
    movingLottiePath: Assets.noShadowPigMove,
    stopLottiePath: Assets.noShadowPigStop,
    horizontalMarkPath: Assets.pigHorizontalMark,
  );

  const AnimalType({
    required this.name,
    required this.movingLottiePath,
    required this.stopLottiePath,
    required this.horizontalMarkPath,
  });

  final String name;
  final String movingLottiePath;
  final String stopLottiePath;
  final String horizontalMarkPath;

  static AnimalType fromString(String name) => switch (name.toLowerCase()) {
        'dog' => AnimalType.dog,
        'rabbit' => AnimalType.rabbit,
        'chicken' => AnimalType.chicken,
        'pig' => AnimalType.pig,
        'sheep' => AnimalType.sheep,
        'tiger' => AnimalType.tiger,
        'dragon' => AnimalType.dragon,
        'snake' => AnimalType.snake,
        'mouse' => AnimalType.mouse,
        'cow' => AnimalType.cow,
        'monkey' => AnimalType.monkey,
        'horse' => AnimalType.horse,
        _ => throw ArgumentError('Unknown animal type: $name'),
      };
}
