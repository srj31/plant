import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/main_menu.dart';
import 'package:game_name/game/our_game.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final OurGame game;

  const GameOverMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pause menu title.
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontFamily: GoogleFonts.play().fontFamily,
                    color: Colors.grey,
                    shadows: const [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'You could not save us all...',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: GoogleFonts.play().fontFamily,
                    color: Colors.white70,
                    shadows: const [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
              // Exit button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.red.shade800),
                    shadowColor: MaterialStateProperty.all(Colors.yellow),
                  ),
                  onPressed: () {
                    game.overlays.remove(GameOverMenu.id);
                    AudioManager.stopBgm();
                    game.resumeEngine();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  },
                  child: Text('Menu',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.play().fontFamily,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ));
  }
}
