import 'package:flame/collisions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyJoyGame()));
}

class MyJoyGame extends FlameGame with HasDraggables, HasCollisionDetection {
  late final JoystickComponent joystick;
  late final SpriteComponent cat;
  late final Bird bird;

  @override
  Future<void> onLoad() async {
    joystick = JoystickComponent(
        knob: CircleComponent(
            radius: 30, paint: BasicPalette.blue.withAlpha(200).paint()),
        background: CircleComponent(
            radius: 100, paint: BasicPalette.blue.withAlpha(100).paint()),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    add(joystick);

    cat = SpriteComponent()
      ..sprite = await loadSprite('cat.png')
      ..size = Vector2.all(100)
      ..debugMode = true;
    cat.add(RectangleHitbox());
    add(cat);

    bird = Bird()
      ..sprite = await loadSprite('bird.png')
      ..size = Vector2.all(100)
      ..position = Vector2.all(400)
      ..debugMode = true;
    bird.add(RectangleHitbox());
    add(bird);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (joystick.direction != JoystickDirection.idle) {
      print(joystick.direction);
    }

    cat.position.add(joystick.relativeDelta * 300 * dt);
  }
}

class Bird extends SpriteComponent with CollisionCallbacks {
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    removeFromParent();
    super.onCollision(intersectionPoints, other);
  }
}
