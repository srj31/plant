import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_name/game/game_tutorial.dart';
import 'package:game_name/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => MainMenuState();
}

class MainMenuState extends State<MainMenu> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setAsset('assets/audio/game_menu.wav');
    _player.setLoopMode(LoopMode.one);
    _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Stack(
                children: [
                  Text(
                    "Plant Inc",
                    style: TextStyle(
                        fontSize: 75,
                        fontStyle: FontStyle.italic,
                        fontFamily: GoogleFonts.play().fontFamily,
                        foreground: Paint()
                          ..color = Colors.green.shade800
                          ..strokeWidth = 5
                          ..style = PaintingStyle.stroke),
                  ),
                  Text(
                    "Plant Inc",
                    style: TextStyle(
                        fontSize: 75,
                        fontStyle: FontStyle.italic,
                        fontFamily: GoogleFonts.play().fontFamily,
                        foreground: Paint()..color = Colors.green),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const OtherScreen(isTutorial: false)));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade800),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.brown),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                child: const Text("Play")),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GameTutorial()));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade800),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.brown),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                child: const Text("Learn More")),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton(
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade800),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.brown),
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                child: const Text("Quit")),
          ),
        ]),
      ),
    ));
  }
}
