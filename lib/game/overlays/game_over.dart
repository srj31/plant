import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/main_menu.dart';
import 'package:game_name/game/our_game.dart';

class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final OurGame game;

  const GameOverMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withAlpha(200),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pause menu title.
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.black87,
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
                  'You could not save us all...',
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
                    game.overlays.remove(GameOverMenu.id);
                    AudioManager.stopBgm();
                    game.resumeEngine();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ),
                    );
                  },
                  child: const Text('Menu'),
                ),
              ),
            ],
          ),
        ));
  }
}
