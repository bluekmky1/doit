import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../consts/animal_type.dart';

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
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }
}

// Lottie를 표시하기 위한 커스텀 컴포넌트
class LottieComponent extends PositionComponent {
  final String stopLottiePath;
  final String movingLottiePath;

  late LottieComposition _stopComposition;
  late LottieComposition _movingComposition;

  late LottieDrawable _drawable;
  late double _time = 0;

  bool isMoving = true;

  LottieComponent({
    required this.stopLottiePath,
    required this.movingLottiePath,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    _stopComposition = await AssetLottie(stopLottiePath).load();
    _movingComposition = await AssetLottie(movingLottiePath).load();

    // 초기 상태는 움직이는 상태
    _drawable = LottieDrawable(_movingComposition);
  }

  void changeToMoving() {
    _drawable = LottieDrawable(_movingComposition);
    isMoving = true;
  }

  void changeToStop() {
    _drawable = LottieDrawable(_stopComposition);
    isMoving = false;
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
    required this.id,
    required Vector2 position,
    required AnimalType animalType,
  })  : _stopLottiePath = animalType.stopLottiePath,
        _movingLottiePath = animalType.movingLottiePath,
        super(
          position: position,
          size: Vector2.all(60),
        );
  final String id;
  final double speed = 40;
  late Vector2 velocity;
  late LottieComponent _lottieComponent;
  final math.Random _random = math.Random();
  final String _stopLottiePath;
  final String _movingLottiePath;
  bool _isFacingLeft = true;
  bool _isMoving = true;
  double _stateChangeTimer = 0;
  double _nextStateChangeTime = 0;
  double _directionChangeTimer = 0;
  double _nextDirectionChangeTime = 0;

  @override
  Future<void> onLoad() async {
    _setRandomVelocity();
    _setNextStateChangeTime();
    _setNextDirectionChangeTime();

    _lottieComponent = LottieComponent(
      stopLottiePath: _stopLottiePath,
      movingLottiePath: _movingLottiePath,
      position: Vector2.zero(),
      size: size,
    );
    add(_lottieComponent);
  }

  void _setRandomVelocity() {
    velocity = (Vector2(
      _random.nextDouble() * 2 - 1,
      _random.nextDouble() * 2 - 1,
    )..normalize())
      ..scale(speed);
  }

  void _setNextStateChangeTime() {
    // 2~5초 사이의 랜덤한 시간 설정
    _nextStateChangeTime = 2 + _random.nextDouble() * 3;
  }

  void _setNextDirectionChangeTime() {
    // 1~3초 사이의 랜덤한 시간 설정
    _nextDirectionChangeTime = 1 + _random.nextDouble() * 2;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 상태 변경 타이머 업데이트
    _stateChangeTimer += dt;
    if (_stateChangeTimer >= _nextStateChangeTime) {
      _stateChangeTimer = 0;
      _setNextStateChangeTime();

      // 움직이는 상태일 때 30% 확률로 상태 변경
      // 움직이지 않는 상태일 때 60% 확률로 상태 변경
      final double changeProb = _isMoving ? 0.3 : 0.6;

      if (_random.nextDouble() < changeProb) {
        _isMoving = !_isMoving;

        if (_isMoving) {
          _lottieComponent.changeToMoving();
          _setRandomVelocity();
        } else {
          _lottieComponent.changeToStop();
        }
      }
    }

    // 움직이는 상태일 때
    if (_isMoving) {
      // 방향 변경 타이머 업데이트
      _directionChangeTimer += dt;
      if (_directionChangeTimer >= _nextDirectionChangeTime) {
        _directionChangeTimer = 0;
        _setNextDirectionChangeTime();

        // 35% 확률로 방향 변경
        if (_random.nextDouble() < 0.35) {
          _setRandomVelocity();
        }
      }

      position += velocity * dt;

      // 이동 방향에 따라 좌우 반전
      if (velocity.x < 0 && !_isFacingLeft) {
        _lottieComponent.flipHorizontallyAroundCenter();
        _isFacingLeft = true;
      } else if (velocity.x > 0 && _isFacingLeft) {
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

  Vector2 get viewSize => screenSize;

  set viewSize(Vector2 size) {
    screenSize = size;
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) => GameWidget<FarmGame>(game: FarmGame());
}
