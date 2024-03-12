import 'package:game_name/game/structures/ev_factory.dart';
import 'package:game_name/game/structures/green_hydrogen.dart';
import 'package:game_name/game/structures/recycling_factory.dart';
import 'package:game_name/game/structures/solar_farm.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/windmill.dart';

class GreenStructureManager {
  static List<(Structure Function(), String)> greenStructures = [
    (() => EvFactory(), "ev_factory.png"),
    (() => GreenHydrogen(), "green_hydrogen.png"),
    (() => RecyclingFactory(), "recycling_factory.png"),
    (() => WindMill(), "windmill.png"),
    (() => SolarFarm(), "solar_farm.png"),
  ];

  static List<(Structure Function(), String)> getInitializedStructures() {
    // pick random 4 unique structures from the list
    final structuresCloned = [...greenStructures];
    structuresCloned.shuffle();
    return structuresCloned.take(4).toList();
  }
}
