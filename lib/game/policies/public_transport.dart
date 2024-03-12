import 'package:game_name/game/policies/policy.dart';

class PublicTransport extends Policy {
  PublicTransport(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 400,
            resources: 30,
            deltaCapital: 30,
            deltaResources: 0.0,
            deltaCarbon: 0.1,
            deltaEnergy: -0.2,
            deltaHealth: 0.05,
            deltaMorale: 0.2,
            timeToPass: 3,
            displayName: "Public Transport Expansion",
            description:
                "Upgrade transportation infrastructure to alleviate congestion, reduce emissions, and enhance urban mobility.",
            id: 'public_transport');

  @override
  Future<void> onLoad() async {
    sprite = game.publicTransport;
    await super.onLoad();
  }
}
