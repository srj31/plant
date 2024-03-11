import 'package:game_name/game/structures/ev_factory.dart';
import 'package:game_name/game/structures/green_hydrogen.dart';
import 'package:game_name/game/structures/recycling_factory.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/windmill.dart';

class GreenStructureManager {
  static List<(Structure, String)> greenStructures = [
    (EvFactory(), "ev_factory.png"),
    (GreenHydrogen(), "green_hydrogen.png"),
    (WindMill(), "windmill.png"),
    (RecyclingFactory(), "recycling_factory.png"),
  ];

  static List<(Structure, String)> getInitializedStructures() {
    return greenStructures;
  }
}
