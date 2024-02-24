import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:game_name/game/our_game.dart';

class PausePlayComponent extends SpriteAnimationComponent
    with HasGameReference<OurGame>, TapCallbacks {
  PausePlayComponent(
      {super.position, super.size, super.scale, super.anchor, super.priority});

  bool isPaused = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final data = SpriteAnimationData.sequenced(
        amount: 4, stepTime: 0.1, textureSize: Vector2(32, 32));

    final sheet = await Flame.images.load("pause_to_play_sheet.png");
    priority = 2;

    animation = SpriteAnimation.fromFrameData(sheet, data);
    playing = false;
  }

  void interact() {
    isPaused = !isPaused;
    game.hasTimerStarted = !isPaused;
    playing = true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    interact();
  }

  @override
  void update(double dt) async {
    if (animationTicker!.isLastFrame) {
      playing = false;
      animation = animation!.reversed();
    }

    super.update(dt);
  }
}
