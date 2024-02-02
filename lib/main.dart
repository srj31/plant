import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:game_name/game/overlays/build.dart';
import 'package:game_name/game/overlays/event.dart';
import 'package:game_name/game/overlays/game_over.dart';
import 'package:game_name/game/overlays/next_level.dart';
import 'package:game_name/game/overlays/non_green.dart';
import 'package:game_name/game/overlays/policies.dart';
import 'package:game_name/game/overlays/research.dart';
import 'package:game_name/game/overlays/specialization.dart';
import 'package:game_name/game/splash_screen.dart';
import 'package:game_name/game/structures/structures.dart';

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
        title: 'Our Game',
        theme: ThemeData.dark(),
        home: const SplashScreenGame());
  }
}

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<OurGame>(
        game: OurGame(),
        overlayBuilderMap: {
          BuildMenu.id: (context, game) => BuildMenu(game: game),
          StructureInfo.id: (context, game) => StructureInfo(game: game),
          ResearchMenu.id: (context, game) => ResearchMenu(game: game),
          PoliciesMenu.id: (context, game) => PoliciesMenu(game: game),
          NonGreenMenu.id: (context, game) => NonGreenMenu(game: game),
          SpecializationMenu.id: (context, game) =>
              SpecializationMenu(game: game),
          GameOverMenu.id: (context, game) => GameOverMenu(game: game),
          NextLevelMenu.id: (context, game) => NextLevelMenu(game: game),
          EventMenu.id: (context, game) => EventMenu(game: game),
        },
        initialActiveOverlays: const [EventMenu.id],
      ),
    );
  }
}
