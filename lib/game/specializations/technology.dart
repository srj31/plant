import 'package:game_name/game/specializations/specialization.dart';

class TechnologySpecialization extends Specialization {
  TechnologySpecialization(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          deltaCapital: 1.5,
          deltaResources: 1.5,
          deltaCarbon: 0.9,
          deltaEnergy: 0.9,
          deltaHealth: 0.9,
          deltaMorale: 0.9,
          timeToBuild: 1.5,
        );
  static const name = 'technology_specialization';
  @override
  Future<void> onLoad() async {
    sprite = game.technologySpecialization;
    await super.onLoad();
  }
}
