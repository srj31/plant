import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/misc_structures/house.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/place_item.dart';

class House extends GameEvent {
  House({required OurGame game, super.priority}) : super(game: game);

  @override
  void handleEvent() {
    game.state = PlaceItemState();
    game.toAdd = HouseStructure();
  }
}
