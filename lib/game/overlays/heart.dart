import 'package:flame/flame.dart';
import 'package:game_name/game/our_game.dart';
import 'package:flame/components.dart';

enum HeartState {
  healthy,
  unhealthy,
  dead,
}

class HeartHealthComponent extends SpriteAnimationGroupComponent<HeartState>
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
    SpriteAnimationData healthyData = SpriteAnimationData.sequenced(
      amount: 5,
      stepTime: 0.2,
      textureSize: Vector2(32, 32),
    );
    SpriteAnimationData unhealthyData = SpriteAnimationData.sequenced(
      amount: 5,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    );

    final healthyHeartSheet = await Flame.images.load("healthy_heart.png");
    final unhealthyHeartSheet = await Flame.images.load("unhealthy_heart.png");

    final healthySprite =
        SpriteAnimation.fromFrameData(healthyHeartSheet, healthyData);
    final unhealthySprite =
        SpriteAnimation.fromFrameData(unhealthyHeartSheet, unhealthyData);

    final deadSprite =
        SpriteAnimation.fromFrameData(unhealthyHeartSheet, unhealthyData);

    animations = {
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
