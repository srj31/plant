import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/our_game.dart';

class ForrestFire extends GameEvent {
  ForrestFire({required OurGame game, super.priority}) : super(game: game);

  @override
  handleEvent() {
    // TODO: implement handleEvent
  }
}
