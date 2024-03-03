import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/specializations/policy.dart';
import 'package:game_name/game/specializations/research.dart';
import 'package:game_name/game/specializations/specialization.dart';
import 'package:game_name/game/specializations/technology.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      Vector2(game.size.x * 0.28, game.size.y * 0.80),
                      TechnologySpecialization(),
                      game.technologySpecialization,
                      "Technology Specialization",
                      "Faster research and implementation of technological advancements.Reduced costs for technology-related upgrades",
                      "Unleash the power of technology to optimize resource management, revolutionize infrastructure, and pioneer eco-friendly solutions. ",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.28, game.size.y * 0.80),
                      PolicySpecialization(),
                      game.policySpecialization,
                      "Policy Specialization",
                      "Quicker rule changes and policy implementations. Higher starting Morale and easier to maintain",
                      "Slower research and adoption of new scientific advancements. Policies may require more capital investment",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.28, game.size.y * 0.80),
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
      this.spriteImage, this.heading, this.advantages, this.description,
      {super.key});
  final OurGame game;
  final String heading;
  final String advantages;
  final Specialization specialization;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;

  final double borderWidth = 5;

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
                  surfaceTintColor: Colors.green,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side:
                        const BorderSide(color: Colors.orangeAccent, width: 5),
                  ),
                  borderOnForeground: false,
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.lightGreen.shade800,
                            Colors.green,
                            Colors.green.shade600
                          ],
                        ),
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: SizedBox(
                      width: size.x,
                      height: size.y,
                    ),
                  ),
                )),
                // Top Part
                Positioned(
                    top: -20,
                    left: size.x * 0.1 + borderWidth,
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
                                      gradient: RadialGradient(
                                        center: Alignment.center,
                                        radius: 1,
                                        colors: [
                                          Colors.lightGreen,
                                          Colors.green.shade900
                                        ],
                                      ),
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
                                          child: BorderedText(
                                            text: specialization.factorMorale
                                                .toStringAsFixed(2),
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
                                          child: BorderedText(
                                            text: specialization.factorCarbon
                                                .toStringAsFixed(2),
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
                                          child: BorderedText(
                                            text: specialization.factorResources
                                                .toStringAsFixed(2),
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
                                          child: BorderedText(
                                            text: specialization.factorEnergy
                                                .toStringAsFixed(2),
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
                                          child: BorderedText(
                                            text: specialization.factorCapital
                                                .toStringAsFixed(2),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ))
                            ])
                          ],
                        ))),
                // The time and cost stats
                Positioned(
                  top: size.y * 0.47,
                  left: 2 * borderWidth,
                  width: size.x,
                  height: size.y * 0.6,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        const Spacer(),
                        Column(children: [
                          SizedBox(
                              width: size.x,
                              height: size.y * 0.3,
                              child: Container(
                                alignment: Alignment.topCenter,
                                decoration: const BoxDecoration(
                                  color: Colors.black12,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10.0,
                                    left: 10.0,
                                    right: 10.0,
                                  ),
                                  child: Text(description,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            GoogleFonts.play().fontFamily,
                                      )),
                                ),
                              )),
                        ]),
                        Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: size.x,
                                height: size.y * 0.1,
                                child: ElevatedButton(
                                    onPressed: () {
                                      game.setSpecialization(specialization);
                                      game.hasTimerStarted = true;
                                      AudioManager.playSfx(
                                          'tap_button.mp3', game.soundVolume);
                                      game.overlays
                                          .remove(SpecializationMenu.id);
                                    },
                                    style: ButtonStyle(
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.yellow),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.amber),
                                    ),
                                    child: Text("CHOOSE",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                GoogleFonts.play().fontFamily,
                                            fontWeight: FontWeight.bold))))),
                      ]),
                )
              ]),
            )));
  }
}

class BorderedText extends StatelessWidget {
  const BorderedText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          'x$text',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..color = Colors.white
                ..strokeWidth = 2.5
                ..style = PaintingStyle.stroke,
              fontFamily: GoogleFonts.play().fontFamily,
              fontSize: 12),
        ),
        Text(
          'x$text',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.play().fontFamily,
              fontSize: 12),
        ),
      ],
    );
  }
}
