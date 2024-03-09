import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/util/delta.dart';

class Upgrade extends Component {
  Upgrade({
    required this.game,
    required this.name,
    required this.capital,
    required this.resources,
    required this.deltaCapital,
    required this.deltaResources,
    required this.deltaCarbon,
    required this.deltaEnergy,
    required this.deltaHealth,
    required this.deltaMorale,
    required this.timeToUpgrade,
    required this.description,
    this.isPurchased = false,
  });

  final String name;
  final String description;

  bool isPurchased;

  final double capital;
  final double resources;

  final double deltaCapital;
  final double deltaResources;
  final double deltaCarbon;
  final double deltaEnergy;
  final double deltaHealth;
  final double deltaMorale;
  final double timeToUpgrade;

  ParamDelta get paramDelta {
    return ParamDelta(
        deltaHealth: deltaHealth,
        deltaMorale: deltaMorale,
        deltaCarbon: deltaCarbon,
        deltaResources: deltaResources,
        deltaEnergy: deltaEnergy,
        deltaCapital: deltaCapital);
  }

  final OurGame game;
}

class UpgradeWidget extends StatefulWidget {
  const UpgradeWidget(this.upgrade, {super.key});

  final Upgrade upgrade;

  @override
  UpgradeWidgetState createState() => UpgradeWidgetState(upgrade);
}

class UpgradeWidgetState extends State<UpgradeWidget> {
  UpgradeWidgetState(this.upgrade) {
    isPurchased = upgrade.isPurchased;
  }
  final Upgrade upgrade;
  bool isPurchased = false;
  bool isPurchasable = false;

  void _clickPurchase() {
    setState(() {
      isPurchased = true;
    });
  }

  void _checkPurchasable() {
    setState(() {
      isPurchasable = upgrade.capital <= upgrade.game.capital &&
          upgrade.resources <= upgrade.game.resources;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ]),
        child: SizedBox(
          height: height * 0.15,
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Text(upgrade.name),
                      Text(
                        upgrade.description,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      _checkPurchasable();
                      if (upgrade.isPurchased) return;
                      if (isPurchasable) {
                        upgrade.game.applyUpgrade(upgrade);
                        _clickPurchase();
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: isPurchased
                                  ? Colors.green.shade800
                                  : Colors.green.shade600.withAlpha(255),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: isPurchased
                                  ? [
                                      const Text("Purchased",
                                          style: TextStyle(fontSize: 10))
                                    ]
                                  : [
                                      Row(
                                        children: [
                                          RawImage(
                                            scale: 1.25,
                                            image: upgrade.game.capitalSprite
                                                .toImageSync(),
                                          ),
                                          Text(
                                              upgrade.capital
                                                  .toStringAsFixed(0),
                                              style: const TextStyle(
                                                  fontSize: 10)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RawImage(
                                            scale: 1.25,
                                            image: upgrade.game.resourcesSprite
                                                .toImageSync(),
                                          ),
                                          Text(
                                              upgrade.resources
                                                  .toStringAsFixed(0),
                                              style: const TextStyle(
                                                  fontSize: 10)),
                                        ],
                                      ),
                                    ],
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
