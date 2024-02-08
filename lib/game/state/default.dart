import 'package:flame/events.dart';
import 'package:game_name/game/our_game.dart';

abstract class AbstractState {
  void handleTap(OurGame game, TapDownEvent info);
  @override
  String toString();
}

class DefaultState extends AbstractState {
  @override
  void handleTap(OurGame game, TapDownEvent info) {}

  @override
  String toString() {
    return 'DefaultState';
  }
}
