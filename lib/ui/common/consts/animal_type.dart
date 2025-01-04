import 'assets.dart';

enum AnimalType {
  dog(
      name: 'dog',
      movingLottiePath: Assets.noShadowDogMove,
      stopLottiePath: Assets.noShadowDogStop),
  rabbit(
      name: 'rabbit',
      movingLottiePath: Assets.noShadowRabbitMove,
      stopLottiePath: Assets.noShadowRabbitStop),
  horse(
      name: 'horse',
      movingLottiePath: Assets.noShadowHorseMove,
      stopLottiePath: Assets.noShadowHorseStop),
  chicken(
      name: 'chicken',
      movingLottiePath: Assets.noShadowChickenMove,
      stopLottiePath: Assets.noShadowChickenStop),
  pig(
      name: 'pig',
      movingLottiePath: Assets.noShadowPigMove,
      stopLottiePath: Assets.noShadowPigStop),
  sheep(
      name: 'sheep',
      movingLottiePath: Assets.noShadowSheepMove,
      stopLottiePath: Assets.noShadowSheepStop),
  tiger(
      name: 'tiger',
      movingLottiePath: Assets.noShadowTigerMove,
      stopLottiePath: Assets.noShadowTigerStop),
  dragon(
      name: 'dragon',
      movingLottiePath: Assets.noShadowDragonMove,
      stopLottiePath: Assets.noShadowDragonStop),
  snake(
      name: 'snake',
      movingLottiePath: Assets.noShadowSnakeMove,
      stopLottiePath: Assets.noShadowSnakeStop),
  mouse(
      name: 'mouse',
      movingLottiePath: Assets.noShadowMouseMove,
      stopLottiePath: Assets.noShadowMouseStop),
  cow(
      name: 'cow',
      movingLottiePath: Assets.noShadowCowMove,
      stopLottiePath: Assets.noShadowCowStop),
  monkey(
      name: 'monkey',
      movingLottiePath: Assets.noShadowMonkeyMove,
      stopLottiePath: Assets.noShadowMonkeyStop);

  const AnimalType({
    required this.name,
    required this.movingLottiePath,
    required this.stopLottiePath,
  });

  final String name;
  final String movingLottiePath;
  final String stopLottiePath;

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
