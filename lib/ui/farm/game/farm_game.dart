import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common/consts/assets.dart';

// 배경 컴포넌트 클래스 추가
class BackgroundComponent extends RectangleComponent {
  BackgroundComponent({required Color color})
      : super(
          paint: Paint()..color = color,
          position: Vector2.zero(),
          size: FarmGame.screenSize,
        );

  @override
  Future<void> onLoad() async {}
}

// 게임 월드 클래스 추가
class FarmWorld extends World {
  final math.Random _random = math.Random();
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

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // // 초기 객체들 생성
    _spawnInitialObjects();
  }

  void _spawnInitialObjects() {
    for (int i = 0; i < 4; i++) {
      final Vector2 position = Vector2(
        _random.nextDouble() * FarmGame.screenSize.x,
        _random.nextDouble() * FarmGame.screenSize.y,
      );
      add(MovableObject(
        position: position,
        lottiePath: lottiePaths[_random.nextInt(lottiePaths.length)],
      ));
    }
  }
}

// Lottie를 표시하기 위한 커스텀 컴포넌트
class LottieComponent extends PositionComponent {
  final String lottiePath;
  late LottieDrawable _drawable;
  late double _time = 0;

  LottieComponent({
    required this.lottiePath,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    final LottieComposition composition = await AssetLottie(lottiePath).load();
    _drawable = LottieDrawable(composition);
  }

  @override
  void render(Canvas canvas) {
    _drawable.draw(
      canvas,
      Rect.fromLTWH(0, 0, size.x, size.y),
    );
  }

  @override
  void update(double dt) {
    _time += dt;
    if (_time >= _drawable.composition.duration.inMilliseconds / 1000) {
      _time = 0;
    }
    _drawable.setProgress(
        _time / (_drawable.composition.duration.inMilliseconds / 1000));
  }
}

// 움직이는 객체 컴포넌트
class MovableObject extends PositionComponent {
  MovableObject({
    required Vector2 position,
    required String lottiePath,
  })  : _lottiePath = lottiePath,
        super(
          position: position,
          size: Vector2.all(60),
        );

  final double speed = 40;
  late Vector2 velocity;
  late LottieComponent _lottieComponent;
  final math.Random _random = math.Random();
  final String _lottiePath;
  bool _isFacingLeft = true;

  @override
  Future<void> onLoad() async {
    _setRandomVelocity();

    // Lottie 컴포넌트 생성 및 추가
    _lottieComponent = LottieComponent(
      lottiePath: _lottiePath, // Lottie 파일 경로
      position: Vector2.zero(),
      size: size,
    );
    // 사각형 대신 Lottie 애니메이션 추가
    add(_lottieComponent);
  }

  void _setRandomVelocity() {
    velocity = (Vector2(
      _random.nextDouble() * 2 - 1,
      _random.nextDouble() * 2 - 1,
    )..normalize())
      ..scale(speed);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;

    // 이동 방향에 따라 좌우 반전
    if (velocity.x < 0 && !_isFacingLeft) {
      // 왼쪽으로 이동할 때
      _lottieComponent.flipHorizontallyAroundCenter();
      _isFacingLeft = true;
    } else if (velocity.x > 0 && _isFacingLeft) {
      // 오른쪽으로 이동할 때
      _lottieComponent.flipHorizontallyAroundCenter();
      _isFacingLeft = false;
    }

    // 화면 경계 충돌 검사
    if (position.x < 0 || position.x > FarmGame.screenSize.x - size.x) {
      velocity.x *= -1;
      position.x = position.x.clamp(0, FarmGame.screenSize.x - size.x);
    }
    if (position.y < 0 || position.y > FarmGame.screenSize.y - size.y) {
      velocity.y *= -1;
      position.y = position.y.clamp(0, FarmGame.screenSize.y - size.y);
    }
  }
}

class FarmGame extends FlameGame<World> {
  static late Vector2 screenSize;

  @override
  Future<void> onLoad() async {
    world = FarmWorld();
    add(world);
    camera.viewfinder.anchor = Anchor.topLeft;
    await super.onLoad();
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) => GameWidget<FarmGame>(game: FarmGame());
}
