import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:game_name/game/misc/text_popup.dart';
import 'package:game_name/game/our_game.dart';

enum PowerState {
  noPower,
}

class NoPowerComponent extends SpriteAnimationGroupComponent<PowerState>
    with HasGameReference<OurGame>, TapCallbacks {
  NoPowerComponent({
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

    final noPowerSpriteSheet = await Flame.images.load('no_power.png');

    final noPowerSprite =
        SpriteAnimation.fromFrameData(noPowerSpriteSheet, data);

    animations = {PowerState.noPower: noPowerSprite};
    size = Vector2.all(32);

    current = PowerState.noPower;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    final popup = TextPopup(
      "Powers off\nneed ${game.calculatePossibleDeltaEnergy().toStringAsFixed(2)} more energy",
      true,
      size: Vector2(125, 50),
      fontSize: 10,
      anchor: Anchor.center,
      timePerChar: 0.0,
      position: Vector2(-size.x / 2, size.y),
    );
    add(popup);

    Future.delayed(const Duration(seconds: 3), () {
      popup.removeFromParent();
    });
  }
}
