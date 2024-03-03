import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game_name/game/our_game.dart';

enum WindState {
  windy,
}

class WindComponent extends SpriteAnimationGroupComponent<WindState>
    with HasGameReference<OurGame> {
  WindComponent({
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
    SpriteAnimationData data = SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 0.1,
      textureSize: Vector2(32, 32),
    );

    final windSpriteSheet = await Flame.images.load('wind.png');

    final windSprite = SpriteAnimation.fromFrameData(windSpriteSheet, data);

    animations = {WindState.windy: windSprite};
    size = Vector2.all(32);

    current = WindState.windy;
  }
}
