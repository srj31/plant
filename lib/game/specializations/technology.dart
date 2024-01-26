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
          factorCapital: 1.1,
          factorResources: 0.95,
          factorCarbon: 1.0,
          factorEnergy: 1.05,
          factorMorale: 0.9,
          factorTechTime: 0.9,
          factorPolicyTime: 1.15,
          factorResearchTime: 0.95,
          factorTechCost: 0.9,
          factorPolicyCost: 1.15,
          factorResearchCost: 1.0,
        );
  static const name = 'technology_specialization';
  @override
  Future<void> onLoad() async {
    sprite = game.technologySpecialization;
    await super.onLoad();
  }
}
