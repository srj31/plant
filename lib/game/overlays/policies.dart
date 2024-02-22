import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/policies/afforestation.dart';
import 'package:game_name/game/policies/carbon_tax.dart';
import 'package:game_name/game/policies/global_treaty.dart';
import 'package:game_name/game/policies/policy.dart';
import 'package:game_name/game/policies/public_transport.dart';

class PoliciesComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  PoliciesComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(await Flame.images.load('policy.png'));
    position = Vector2(game.size.x * 0.05, game.size.y * 0.55);
    anchor = Anchor.center;
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(PoliciesMenu.id);
    AudioManager.playSfx('opening_overlay.wav', game.soundVolume);
  }
}

class PoliciesMenu extends StatelessWidget {
  static const id = 'PoliciesMenu';
  final OurGame game;

  const PoliciesMenu({super.key, required this.game});

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
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        PublicTransport(),
                        game.publicTransport,
                        "Public Transportation Expansion",
                        "Propel environmental progress by investing in robust public transit systems. Reduce traffic congestion, lower emissions, and improve urban air quality with expanded public transportation options, fostering sustainable mobility and vibrant communities"),
                    ElevatedCard(
                        game,
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        CarbonTax(),
                        game.carbonTax,
                        "Carbon Tax Implementation",
                        "Take decisive action against climate change with a carbon tax. Incentivize emissions reduction, spur innovation in clean energy, and generate revenue for environmental initiatives, paving the way for a greener and more prosperous future.")
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      Afforestation(),
                      game.afforestation,
                      "Afforestation Program",
                      "Embrace nature's solution to climate change with a proactive afforestation initiative. Restore ecosystems, mitigate carbon emissions, and enhance biodiversity by planting trees, fostering green spaces, and safeguarding the planet for generations to come.",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      GlobalTreaty(),
                      game.globalTreaty,
                      "Global Collaboration Treaty",
                      "Forge international unity in the fight against climate change with a comprehensive global treaty. Coordinate efforts, share resources, and amplify impact on a global scale, ushering in a new era of cooperation and collective responsibility for a sustainable future.",
                    )
                  ])
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.policy, this.spriteImage,
      this.heading, this.description);
  final OurGame game;
  final String heading;
  final Policy policy;
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
                  color: Colors.green,
                  elevation: 10,
                  child: SizedBox(
                    width: size.x,
                    height: size.y,
                  ),
                )),
                Positioned(
                    top: -15,
                    left: 5,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(clipBehavior: Clip.none, children: [
                              Container(
                                  width: size.x * 0.5,
                                  height: size.y,
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RawImage(
                                      image: spriteImage.toImageSync(),
                                    ),
                                  )),
                              Positioned(
                                  top: size.y * 0.1,
                                  left: -size.x * 0.07,
                                  child: Column(
                                    children: [
                                      Stack(clipBehavior: Clip.none, children: [
                                        SizedBox(
                                            width: size.x * 0.18,
                                            height: size.y * 0.15,
                                            child: Card(
                                              elevation: 5,
                                              color: policy.deltaMorale >= 0
                                                  ? Colors.green
                                                  : Colors.red.shade900,
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
                                            policy.deltaMorale
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                      Stack(clipBehavior: Clip.none, children: [
                                        SizedBox(
                                            width: size.x * 0.18,
                                            height: size.y * 0.15,
                                            child: Card(
                                              elevation: 5,
                                              color: policy.deltaCarbon >= 0
                                                  ? Colors.green
                                                  : Colors.red.shade900,
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
                                            policy.deltaCarbon
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                      Stack(children: [
                                        SizedBox(
                                            width: size.x * 0.18,
                                            height: size.y * 0.15,
                                            child: Card(
                                              elevation: 5,
                                              color: policy.deltaResources >= 0
                                                  ? Colors.green
                                                  : Colors.red.shade900,
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
                                            policy.deltaResources
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.white,
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
                                            width: size.x * 0.18,
                                            height: size.y * 0.15,
                                            child: Card(
                                              elevation: 5,
                                              color: policy.deltaEnergy >= 0
                                                  ? Colors.green
                                                  : Colors.red.shade900,
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
                                            policy.deltaEnergy
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                      Stack(children: [
                                        SizedBox(
                                            width: size.x * 0.18,
                                            height: size.y * 0.15,
                                            child: Card(
                                              elevation: 5,
                                              color: policy.deltaCapital >= 0
                                                  ? Colors.green
                                                  : Colors.red.shade900,
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
                                            policy.deltaCapital
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  )),
                            ])
                          ],
                        ))),
                Positioned(
                    top: 10,
                    right: 0,
                    width: size.x / 2 - 5,
                    height: size.y,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(heading,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(description,
                                style: const TextStyle(fontSize: 10)),
                          ]),
                    )),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (policy.capital <= game.capital &&
                                      policy.resources <= game.resources) {
                                    AudioManager.playSfx(
                                        'tap_button.mp3', game.soundVolume);
                                    game.overlays.remove(PoliciesMenu.id);
                                    game.startPolicy(policy);
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: policy.capital <=
                                              game.capital &&
                                          policy.resources <= game.resources
                                      ? MaterialStateProperty.all(Colors.green)
                                      : MaterialStateProperty.all(Colors.grey),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(size.x * 0.5, 20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RawImage(
                                      image: game.capitalSprite.toImageSync(),
                                    ),
                                    Text(policy.capital.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 10)),
                                    const Spacer(),
                                    RawImage(
                                      image: game.resourcesSprite.toImageSync(),
                                    ),
                                    Text(policy.resources.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 10)),
                                  ],
                                )))))
              ]),
            )));
  }
}
