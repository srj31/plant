import 'package:flutter/material.dart';
import 'package:game_name/game/main_menu.dart';
import 'package:game_name/game/our_game.dart';
import 'package:google_fonts/google_fonts.dart';

class NextLevelMenu extends StatelessWidget {
  static const String id = 'NextLevelMenu';
  final OurGame game;

  const NextLevelMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pause menu title.
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Nice Work',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.green,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.grey,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'You have saved us all, but it does not end here!',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white70,
                    shadows: [
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
                        MaterialStateProperty.all(Colors.green.shade800),
                    shadowColor: MaterialStateProperty.all(Colors.yellow),
                  ),
                  onPressed: () {
                    game.overlays.remove(NextLevelMenu.id);
                    game.nextLevel();
                  },
                  child: Text('Next Level',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: GoogleFonts.play().fontFamily,
                          fontWeight: FontWeight.bold)),
                ),
              ),
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
                    game.overlays.remove(NextLevelMenu.id);
                    game.resumeEngine();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  },
                  child: Text('Exit',
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
