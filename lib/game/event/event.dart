import 'package:flame/components.dart';
import 'package:game_name/game/our_game.dart';

class GameEvent extends Component {
  GameEvent({required this.game, super.priority});
  OurGame game;
  void handleEvent() {
  }
}
