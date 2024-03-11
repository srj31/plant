import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/event/earthquake.dart';
import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/event/forrest_fire.dart';
import 'package:game_name/game/our_game.dart';
import 'package:google_fonts/google_fonts.dart';

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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedCard(
                game,
                Vector2(game.size.x * 0.30, game.size.y * 0.80),
                Earthquake(game: game),
                game.earthquake,
                "Earthquake",
                "Witness the devastating aftermath of prolonged strain on Earth's health as structures crumble under seismic activity.",
              ),
              ElevatedCard(
                game,
                Vector2(game.size.x * 0.30, game.size.y * 0.80),
                ForrestFire(game: game),
                game.forrestFire,
                "Forrest Fire",
                "Experience the ferocity of wildfires fueled by escalating global temperatures. Witness the destruction of precious ecosystems and habitats as forests blaze under the intensified heat of climate change.",
              ),
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
                  surfaceTintColor: Colors.lightGreen,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                        color: Colors.orangeAccent, width: borderWidth),
                  ),
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red.shade800,
                            Colors.red.shade600,
                            Colors.orange.shade700
                          ],
                        )),
                    child: SizedBox(
                      width: size.x,
                      height: size.y,
                    ),
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
                                        gradient: RadialGradient(
                                          center: Alignment.center,
                                          radius: 1,
                                          colors: [
                                            Colors.orange,
                                            Colors.red.shade900
                                          ],
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.red,
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
                  top: size.y * 0.375,
                  left: size.x * 0.1 + borderWidth,
                  child: Center(
                      child: Container(
                    alignment: Alignment.center,
                    width: size.x * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.amber.shade800,
                          Colors.amber,
                          Colors.amber.shade600
                        ],
                      ),
                    ),
                    child: Text(heading,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  )),
                ),
                Positioned(
                    top: size.y * 0.5,
                    left: 2 * borderWidth,
                    width: size.x * 0.95,
                    height: size.y * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.x,
                              height: size.y * 0.45,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.orange.withAlpha(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      description,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily:
                                              GoogleFonts.play().fontFamily,
                                          fontSize: 12),
                                    ),
                                  )),
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: size.x,
                                    height: size.y * 0.1,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          game.hasTimerStarted = true;
                                          gameEvent.handleEvent();
                                          game.overlays.remove(EventMenu.id);
                                          AudioManager.playSfx('tap_button.mp3',
                                              game.soundVolume);
                                        },
                                        style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateProperty.all(
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
                                                fontFamily: GoogleFonts.play()
                                                    .fontFamily,
                                                fontWeight:
                                                    FontWeight.bold))))),
                          ]),
                    )),
              ]),
            )));
  }
}
