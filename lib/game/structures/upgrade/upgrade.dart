import 'package:flutter/material.dart';

class Upgrade {
  Upgrade({
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
}

class UpgradeWidget extends StatelessWidget {
  const UpgradeWidget(this.upgrade, {super.key});

  final Upgrade upgrade;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(upgrade.name),
      Text(upgrade.description),
      ElevatedButton(
          onPressed: () {
            upgrade.isPurchased = true;
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: upgrade.isPurchased
                ? MaterialStateProperty.all(Colors.green)
                : MaterialStateProperty.all(Colors.grey),
          ),
          child: const Text('Upgrade')),
    ]);
  }
}
