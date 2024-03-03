import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game_name/game/our_game.dart';

enum WeatherState {
  sunny,
}

class WeatherComponent extends SpriteAnimationGroupComponent<WeatherState>
    with HasGameReference<OurGame> {
  WeatherComponent({
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

    final sunSpriteSheet = await Flame.images.load('sun.png');

    final sunSprite = SpriteAnimation.fromFrameData(sunSpriteSheet, data);

    animations = {WeatherState.sunny: sunSprite};
    size = Vector2.all(32);

    current = WeatherState.sunny;
  }
}
