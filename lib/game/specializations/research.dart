
import 'package:game_name/game/specializations/specialization.dart';

class ResearchSpecialization extends Specialization {
  ResearchSpecialization(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          deltaCapital: 1.5,
          deltaResources: 1.5,
          deltaCarbon: 1.0,
          deltaEnergy: 1.0,
          deltaHealth: 1.0,
          deltaMorale: 1.0,
          timeToBuild: 1.5,
        );
  static const name = 'research_specialization';
  @override
  Future<void> onLoad() async {
    sprite = game.researchSpecialization;
    await super.onLoad();
  }
}
