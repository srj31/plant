import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';

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
    return Container(
        child: Card(
            color: Colors.green,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(children: [
              Text(upgrade.name),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        upgrade.description,
                        style: const TextStyle(fontSize: 12),
                      )),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        height: 30,
                        child: TextButton(
                            onPressed: () {
                              _checkPurchasable();
                              if (upgrade.isPurchased) return;
                              if (isPurchasable) {
                                upgrade.game.applyUpgrade(upgrade);
                                _clickPurchase();
                              }
                            },
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                backgroundColor: isPurchased
                                    ? MaterialStateProperty.all(Colors.blueGrey)
                                    : MaterialStateProperty.all(
                                        Colors.green)),
                            child: isPurchased
                                ? const Text("Purchased",
                                    style: TextStyle(fontSize: 10))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RawImage(
                                        image: upgrade.game.capitalSprite
                                            .toImageSync(),
                                      ),
                                      Text(upgrade.capital.toStringAsFixed(0),
                                          style: const TextStyle(fontSize: 10)),
                                      const Spacer(),
                                      RawImage(
                                        image: upgrade.game.resourcesSprite
                                            .toImageSync(),
                                      ),
                                      Text(upgrade.resources.toStringAsFixed(0),
                                          style: const TextStyle(fontSize: 10)),
                                    ],
                                  ))),
                  )
                ],
              )
            ])));
  }
}
