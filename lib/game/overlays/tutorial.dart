import 'package:flutter/material.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});
  static const id = 'Tutorial';

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  List<Widget> widgets = [TutorialOne()];

  int stage = 0;

  void nextState() {
    setState(() {
      stage += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleTutorial();
  }
}

class SimpleTutorial extends StatelessWidget {
  const SimpleTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center());
  }
}

class TutorialOne extends StatelessWidget {
  TutorialOne({super.key});

  final Size deviceSize = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(10),
      body: Positioned.fill(
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Colors.black87,
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: deviceSize.width * 0.3,
                  height: deviceSize.height * 0.9,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
