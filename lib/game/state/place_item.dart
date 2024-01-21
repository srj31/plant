import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/default.dart';

class PlaceItemState extends AbstractState {
  @override
  void handleTap(OurGame game, TapDownEvent info) {
    final tappedCel = game.getTappedCell(info);


    final spriteComponent = game.toAdd
      ..anchor = Anchor.center
      ..position = Vector2(tappedCel.center.dx, tappedCel.center.dy)
      ..priority = 1;

    game.addBuiltItem(spriteComponent);

    game.state = DefaultState();
  }
}
