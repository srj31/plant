import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:game_name/game/overlays/build.dart';

import 'game/our_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Platformer',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: GameWidget<OurGame>(
          game: OurGame(),
          overlayBuilderMap: {
            BuildMenu.id: (context, game) => BuildMenu(game: game),
          },
          initialActiveOverlays: [BuildMenu.id],
        ),
      ),
    );
    return GameWidget(game: OurGame());
  }
}
