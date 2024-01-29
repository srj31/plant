import 'package:game_name/game/specializations/specialization.dart';

class ResearchSpecialization extends Specialization {
  ResearchSpecialization({super.priority})
      : super(
          factorCapital: 0.95,
          factorResources: 1.05,
          factorCarbon: 1.05,
          factorEnergy: 1.05,
          factorMorale: 0.9,
          factorTechTime: 0.95,
          factorPolicyTime: 1.15,
          factorResearchTime: 0.9,
          factorTechCost: 1.0,
          factorPolicyCost: 1.15,
          factorResearchCost: 0.9,
        );
  static const name = 'research_specialization';
  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
