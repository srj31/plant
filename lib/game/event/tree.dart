import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/misc_structures/tree.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/place_item.dart';

class Tree extends GameEvent {
  Tree({required OurGame game, super.priority}) : super(game: game);

  @override
  void handleEvent() {
    game.state = PlaceItemState();
    game.toAdd = TreeStructure();
  }
}
