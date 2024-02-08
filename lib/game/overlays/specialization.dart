import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/specializations/policy.dart';
import 'package:game_name/game/specializations/research.dart';
import 'package:game_name/game/specializations/specialization.dart';
import 'package:game_name/game/specializations/technology.dart';

class SpecializationMenu extends StatelessWidget {
  static const id = 'SpecializationMenu';
  final OurGame game;

  const SpecializationMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Scaffold(
            backgroundColor: Colors.black.withAlpha(100),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      TechnologySpecialization(),
                      game.technologySpecialization,
                      "Technology Specialization",
                      "Faster research and implementation of technological advancements.Reduced costs for technology-related upgrades",
                      "Slower decision-making in rule changes and policy implementations. Less influence on policy-related parameters like Morale and Health",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      PolicySpecialization(),
                      game.policySpecialization,
                      "Policy Specialization",
                      "Quicker rule changes and policy implementations. Higher starting Morale and easier to maintain",
                      "Slower research and adoption of new scientific advancements. Policies may require more capital investment",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      ResearchSpecialization(),
                      game.researchSpecialization,
                      "Research Specialization",
                      "Faster progress in scientific advancements. Reduced costs for scientific research and development. ",
                      "Slower in enacting new rules and policy changes. Lower starting Morale and harder to maintain.",
                    ),
                  ]),
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.specialization,
      this.spriteImage, this.heading, this.advantages, this.description);
  final OurGame game;
  final String heading;
  final String advantages;
  final Specialization specialization;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                    child: Card(
                  surfaceTintColor: Colors.lightGreen,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side:
                        const BorderSide(color: Colors.orangeAccent, width: 5),
                  ),
                  elevation: 10,
                  child: SizedBox(
                    width: size.x,
                    height: size.y,
                  ),
                )),
                Positioned(
                    top: -10,
                    left: size.x * 0.1,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(clipBehavior: Clip.none, children: [
                              Container(
                                  width: size.x * 0.8,
                                  height: size.y * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.lightGreen,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.green,
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RawImage(
                                      image: spriteImage.toImageSync(),
                                      fit: BoxFit.contain,
                                    ),
                                  )),
                              Positioned(
                                  top: size.y * 0.1,
                                  left: -size.x * 0.05,
                                  child: Column(
                                    children: [
                                      Stack(clipBehavior: Clip.none, children: [
                                        SizedBox(
                                            width: size.x * 0.22,
                                            height: size.y * 0.1,
                                            child: const Card(
                                              color: Colors.amberAccent,
                                            )),
                                        Positioned(
                                            top: size.y * 0.01,
                                            left: size.x * 0.02,
                                            child: RawImage(
                                                image: game.moraleSprite
                                                    .toImageSync())),
                                        Positioned(
                                          bottom: size.y * 0.02,
                                          right: size.x * 0.02,
                                          child: Text(
                                            'x${specialization.factorMorale.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                      Stack(children: [
                                        SizedBox(
                                            width: size.x * 0.22,
                                            height: size.y * 0.1,
                                            child: const Card(
                                              color: Colors.amberAccent,
                                            )),
                                        Positioned(
                                            top: size.y * 0.01,
                                            left: size.x * 0.02,
                                            child: RawImage(
                                                image: game.carbonEmissionSprite
                                                    .toImageSync())),
                                        Positioned(
                                          bottom: size.y * 0.02,
                                          right: size.x * 0.02,
                                          child: Text(
                                            'x${specialization.factorCarbon.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                      Stack(children: [
                                        SizedBox(
                                            width: size.x * 0.22,
                                            height: size.y * 0.1,
                                            child: const Card(
                                              color: Colors.amberAccent,
                                            )),
                                        Positioned(
                                            top: size.y * 0.01,
                                            left: size.x * 0.02,
                                            child: RawImage(
                                                image: game.resourcesSprite
                                                    .toImageSync())),
                                        Positioned(
                                          bottom: size.y * 0.02,
                                          right: size.x * 0.02,
                                          child: Text(
                                            'x${specialization.factorResources.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  )),
                              Positioned(
                                  top: size.y * 0.15,
                                  right: -size.x * 0.05,
                                  child: Column(
                                    children: [
                                      Stack(children: [
                                        SizedBox(
                                            width: size.x * 0.22,
                                            height: size.y * 0.1,
                                            child: const Card(
                                              color: Colors.amberAccent,
                                            )),
                                        Positioned(
                                            top: size.y * 0.01,
                                            left: size.x * 0.02,
                                            child: RawImage(
                                                image: game.energySprite
                                                    .toImageSync())),
                                        Positioned(
                                          bottom: size.y * 0.02,
                                          right: size.x * 0.02,
                                          child: Text(
                                            'x${specialization.factorEnergy.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                      Stack(children: [
                                        SizedBox(
                                            width: size.x * 0.22,
                                            height: size.y * 0.1,
                                            child: const Card(
                                              color: Colors.amberAccent,
                                            )),
                                        Positioned(
                                            top: size.y * 0.01,
                                            left: size.x * 0.02,
                                            child: RawImage(
                                                image: game.capitalSprite
                                                    .toImageSync())),
                                        Positioned(
                                          bottom: size.y * 0.02,
                                          right: size.x * 0.02,
                                          child: Text(
                                            'x${specialization.factorCapital.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ))
                            ])
                          ],
                        ))),
                Positioned(
                  top: size.y * 0.5,
                  right: 0,
                  width: size.x,
                  height: size.y * 0.5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        width: size.x *
                                            0.2 *
                                            specialization.factorTechTime,
                                        height: size.y * 0.05,
                                        child: const Card(
                                          color: Colors.amber,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                    width: size.x *
                                        0.2 *
                                        specialization.factorPolicyTime,
                                    height: size.y * 0.05,
                                    child: const Card(
                                      color: Colors.amber,
                                    )),
                                SizedBox(
                                    width: size.x *
                                        0.2 *
                                        specialization.factorResearchTime,
                                    height: size.y * 0.05,
                                    child: const Card(
                                      color: Colors.amber,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                        width: size.x *
                                            0.2 *
                                            specialization.factorTechCost,
                                        height: size.y * 0.05,
                                        child: const Card(
                                          color: Colors.amber,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                    width: size.x *
                                        0.2 *
                                        specialization.factorPolicyCost,
                                    height: size.y * 0.05,
                                    child: const Card(
                                      color: Colors.amber,
                                    )),
                                SizedBox(
                                    width: size.x *
                                        0.2 *
                                        specialization.factorResearchCost,
                                    height: size.y * 0.05,
                                    child: const Card(
                                      color: Colors.amber,
                                    )),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          color: Colors.orangeAccent,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                                height: 25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      game.setSpecialization(specialization);
                                      // game.hasTimerStarted = true;
                                      game.overlays
                                          .remove(SpecializationMenu.id);
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                    child: const Text("Choose")))),
                        const Divider(
                          color: Colors.orangeAccent,
                        ),
                        Text(description,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.black))
                      ]),
                )
              ]),
            )));
  }
}
