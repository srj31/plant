import 'package:flame/components.dart';
import 'package:flame/game.dart';
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
        onTap: () {
          game.overlays.remove(id);
        },
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
      this.spriteImage, this.heading, this.advantages, this.disadvantages);
  final OurGame game;
  final String heading;
  final String advantages;
  final Specialization specialization;
  final String disadvantages;

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
                  elevation: 10,
                  child: SizedBox(
                    width: size.x,
                    height: size.y,
                  ),
                )),
                Positioned(
                    top: -10,
                    left: 5,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: size.x,
                        height: size.y * 0.33,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: RawImage(
                          image: spriteImage.toImageSync(),
                        ),
                      ),
                    )),
                Positioned(
                  top: size.y * 0.33,
                  right: 0,
                  width: size.x,
                  height: size.y * 0.66,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(advantages, style: const TextStyle(fontSize: 12)),
                        Text(disadvantages,
                            style: const TextStyle(fontSize: 12)),
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      game.specialization = specialization;
                                      game.overlays
                                          .remove(SpecializationMenu.id);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                    ),
                                    child: const Text("Choose"))))
                      ]),
                )
              ]),
            )));
  }
}
