import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_name/game/our_game.dart';

class FinishBuildingEffect extends SpriteAnimationComponent
    with HasGameReference<OurGame> {
  FinishBuildingEffect({
    required super.position,
    super.priority,
    super.size,
    super.scale,
  });
  @override
  FutureOr<void> onLoad() async {
    removeOnFinish = true;
    animation = SpriteAnimation.fromFrameData(
      await game.images.load('built_complete.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
