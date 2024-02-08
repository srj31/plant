import 'package:flame/components.dart';
import 'package:game_name/game/our_game.dart';

class Specialization extends Component with HasGameReference<OurGame> {
  Specialization({
    super.priority,
    required this.factorCapital,
    required this.factorResources,
    required this.factorCarbon,
    required this.factorEnergy,
    required this.factorMorale,
    required this.factorTechTime,
    required this.factorPolicyTime,
    required this.factorResearchTime,
    required this.factorTechCost,
    required this.factorPolicyCost,
    required this.factorResearchCost,
  });

  final double factorCapital;
  final double factorResources;
  final double factorCarbon;
  final double factorEnergy;
  final double factorMorale;
  final double factorTechTime;
  final double factorPolicyTime;
  final double factorResearchTime;
  final double factorTechCost;
  final double factorPolicyCost;
  final double factorResearchCost;
}
