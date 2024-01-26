import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
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
    sprite = game.getObjectSprite(944, 343, 23, 37);
    position = Vector2(50, 150);
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(PoliciesMenu.id);
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
                        "^CO ^Morale",
                        "Reduces Carbon Emission, improves Morale good for all"),
                    ElevatedCard(
                        game,
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        CarbonTax(),
                        game.carbonTax,
                        "Carbon Tax Implementation",
                        "^Capital ^Co vMorale",
                        "Positive on Capital, negative on Morale")
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      Afforestation(),
                      game.afforestation,
                      "Afforestation Program",
                      "^CO ^Resource",
                      "Positive on Health, Resources, and Morale",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      GlobalTreaty(),
                      game.globalTreaty,
                      "Global Collaboration Treaty",
                      "^Morale ^CO",
                      "Positive on Morale and globally on Carbon Emission",
                    )
                  ])
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.policy, this.spriteImage,
      this.heading, this.subheading, this.description);
  final OurGame game;
  final String heading;
  final String subheading;
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
                          width: size.x / 2,
                          height: size.y,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RawImage(
                              image: spriteImage.toImageSync(),
                            ),
                          )),
                    )),
                Positioned(
                  top: 10,
                  right: 0,
                  width: size.x / 2 - 5,
                  height: size.y,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(subheading, style: const TextStyle(fontSize: 12)),
                        Text(description, style: const TextStyle(fontSize: 10)),
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      game.overlays.remove(PoliciesMenu.id);
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      backgroundColor: policy.capital <=
                                                  game.capital &&
                                              policy.resources <= game.resources
                                          ? MaterialStateProperty.all(
                                              Colors.green)
                                          : MaterialStateProperty.all(
                                              Colors.grey),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(size.x * 0.45, 20)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RawImage(
                                          image:
                                              game.capitalSprite.toImageSync(),
                                        ),
                                        Text(policy.capital.toStringAsFixed(0),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                        const Spacer(),
                                        RawImage(
                                          image: game.resourcesSprite
                                              .toImageSync(),
                                        ),
                                        Text(
                                            policy.resources.toStringAsFixed(0),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                      ],
                                    ))))
                      ]),
                )
              ]),
            )));
  }
}