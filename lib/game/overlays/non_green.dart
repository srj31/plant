import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/policies/afforestation.dart';
import 'package:game_name/game/policies/carbon_tax.dart';
import 'package:game_name/game/policies/global_treaty.dart';
import 'package:game_name/game/policies/policy.dart';
import 'package:game_name/game/policies/public_transport.dart';

class NonGreenComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  NonGreenComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    sprite = game.getObjectSprite(282, 484, 32, 26);
    position = Vector2(50, 200);
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(NonGreenMenu.id);
  }
}

class NonGreenMenu extends StatelessWidget {
  static const id = 'NonGreenMenu';
  final OurGame game;

  const NonGreenMenu({super.key, required this.game});

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
                        "Fossil Fuel Energy",
                        "^CO ^Morale",
                        "Effect: Provides immediate and cheap energy. Negative Effects: High carbon emissions, air pollution, health risks, and ecosystem degradation"),
                    ElevatedCard(
                        game,
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        CarbonTax(),
                        game.carbonTax,
                        "Deforrestation",
                        "^Capital ^Co vMorale",
                        "Effect: Clearing land for agricultural purposes. Negative Effects: Loss of biodiversity, habitat destruction, soil erosion, increased carbon emissions, and loss of ecosystem services.")
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      Afforestation(),
                      game.afforestation,
                      "Plastic Manufacturing",
                      "^CO ^Resource",
                      "Effect: Low production costs for disposable items. Negative Effects: Plastic pollution in oceans and ecosystems, harm to marine life, and long-lasting environmental impact.",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      GlobalTreaty(),
                      game.globalTreaty,
                      "Waste Incineration",
                      "^Morale ^CO",
                      "Effect: Quick disposal of waste. Negative Effects: Air pollution, release of toxic chemicals, contribution to climate change, and potential health hazards.",
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
                                      game.overlays.remove(NonGreenMenu.id);
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
