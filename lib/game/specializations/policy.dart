import 'package:game_name/game/specializations/specialization.dart';

class PolicySpecialization extends Specialization {
  PolicySpecialization({super.priority})
      : super(
          factorCapital: 0.9,
          factorResources: 0.95,
          factorCarbon: 1.05,
          factorEnergy: 1.0,
          factorMorale: 1.1,
          factorTechTime: 1.15,
          factorPolicyTime: 0.9,
          factorResearchTime: 0.95,
          factorTechCost: 1.15,
          factorPolicyCost: 0.9,
          factorResearchCost: 1.0,
        );
  static const name = 'policy_specialization';
  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
