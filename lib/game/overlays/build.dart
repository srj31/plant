import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:game_name/game/our_game.dart';

class BuildComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  BuildComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    print("ONLOAD CALLED");
    sprite = await game.loadSprite(
      'dead_heart.png',
      srcSize: Vector2.all(300),
    );
    position = Vector2(100, 100);
    size = Vector2.all(32);
    add(TextComponent(
      text: "BUILD",
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      anchor: Anchor.center,
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(BuildMenu.id);
  }
}

class BuildMenu extends StatelessWidget {
  static const id = 'BuildMenu';
  final OurGame game;

  const BuildMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          game.overlays.remove(id);
        },
        child: Scaffold(
          backgroundColor: Colors.black.withAlpha(100),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedCard(Vector2(game.size.x * 0.27, game.size.y * 0.40)),
                  ElevatedCard(Vector2(game.size.x * 0.27, game.size.y * 0.40)),
                  ElevatedCard(Vector2(game.size.x * 0.27, game.size.y * 0.40)),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedCard(Vector2(game.size.x * 0.27, game.size.y * 0.40)),
                  ElevatedCard(Vector2(game.size.x * 0.27, game.size.y * 0.40)),
                  ElevatedCard(Vector2(game.size.x * 0.27, game.size.y * 0.40)),
                ])
              ],
            ),
          ),
        ));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.size);
  final Vector2 size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () {},
      child: Stack(children: [
        Positioned(
            child: Card(
          elevation: 10,
          child: SizedBox(
            width: size.x,
            height: size.y,
          ),
        )),
        Positioned(
            top: -10,
            left: 5,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: size.x / 2,
                height: size.y,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                        image: NetworkImage('https://picsum.photos/200/300'),
                        fit: BoxFit.fill)),
                child: const Center(child: Text('Lol Card')),
              ),
            )),
        Positioned(
          top: 10,
          right: 0,
          width: size.x / 2 - 10,
          height: size.y,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Heading",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Subheading", style: TextStyle(fontSize: 12)),
            Text(
                "This is the description of the item that you will be using so be careful of it ",
                style: TextStyle(fontSize: 10)),
            ButtonTheme(
                height: 1,
                minWidth: 1,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text("Buy")))
          ]),
        )
      ]),
    ));
  }
}
