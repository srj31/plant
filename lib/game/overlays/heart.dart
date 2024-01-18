import 'package:game_name/game/our_game.dart';
import 'package:flame/components.dart';

enum HeartState {
  healthy,
  unhealthy,
  dead,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameReference<OurGame> {
  HeartHealthComponent({
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final healthySprite = await game.loadSprite(
      'healthy_heart.png',
      srcSize: Vector2.all(300),
    );

    final unhealthySprite = await game.loadSprite(
      'unhealthy_heart.png',
      srcSize: Vector2.all(300),
    );
    final deadSprite = await game.loadSprite(
      'dead_heart.png',
      srcSize: Vector2.all(300),
    );

    sprites = {
      HeartState.healthy: healthySprite,
      HeartState.unhealthy: unhealthySprite,
      HeartState.dead: deadSprite,
    };

    current = HeartState.unhealthy;
  }

  @override
  void update(double dt) {
    if (game.health == 0) {
      current = HeartState.dead;
    } else if (game.health < 50) {
      current = HeartState.unhealthy;
    } else {
      current = HeartState.healthy;
    }
    super.update(dt);
  }
}
