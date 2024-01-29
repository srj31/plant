import 'package:flutter/material.dart';
import 'package:game_name/game/main_menu.dart';
import 'package:game_name/game/our_game.dart';

class NextLevelMenu extends StatelessWidget {
  static const String id = 'NextLevelMenu';
  final OurGame game;

  const NextLevelMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withAlpha(100),
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
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Yay you have saved us all! How about we try another world',
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
                  onPressed: () {
                    game.overlays.remove(NextLevelMenu.id);
                    game.nextLevel();
                  },
                  child: const Text('Next Level'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 5,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove(NextLevelMenu.id);
                    game.resumeEngine();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  },
                  child: const Text('Exit'),
                ),
              ),
            ],
          ),
        ));
  }
}
