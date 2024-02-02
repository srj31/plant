import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/event/earthquake.dart';
import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/event/flood.dart';
import 'package:game_name/game/event/forrest_fire.dart';
import 'package:game_name/game/our_game.dart';

class EventMenu extends StatelessWidget {
  static const id = 'EventMenu';
  final OurGame game;

  const EventMenu({super.key, required this.game});

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
                      Earthquake(game: game),
                      game.technologySpecialization,
                      "Earthquake",
                      "Faster research and implementation of technological advancements.Reduced costs for technology-related upgrades",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      Flood(game: game),
                      game.policySpecialization,
                      "Flood",
                      "Quicker rule changes and policy implementations. Higher starting Morale and easier to maintain",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      ForrestFire(game: game),
                      game.researchSpecialization,
                      "Forrest Fire",
                      "Faster progress in scientific advancements. Reduced costs for scientific research and development. ",
                    ),
                  ]),
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.gameEvent, this.spriteImage,
      this.heading, this.description,
      {super.key});
  final OurGame game;
  final String heading;
  final GameEvent gameEvent;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              game.hasTimerStarted = true;
              gameEvent.handleEvent();
              game.overlays.remove(EventMenu.id);
            },
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                              ])
                            ]))),
                Positioned(
                    top: size.y * 0.5,
                    left: size.x * 0.1,
                    width: size.x * 0.8,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            heading,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            description,
                            style: const TextStyle(fontSize: 12),
                          )
                        ]))
              ]),
            )));
  }
}
