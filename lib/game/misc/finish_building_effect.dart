import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_name/game/our_game.dart';

class FinishBuildingEffect extends SpriteAnimationComponent
    with HasGameReference<OurGame> {
  @override
  FutureOr<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('built_complete.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.05,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );

    await animationTicker?.completed;
    removeFromParent();
  }
}
