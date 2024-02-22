import 'package:fl_chart/fl_chart.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';

class StatsComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  StatsComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(await Flame.images.load('build.png'));
    position = Vector2(game.deviceSize.width - 100, 100);
    size = Vector2.all(32);
    priority = 2;
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.pause();
    game.overlays.add(StatsMenu.id);
  }
}

class StatsMenu extends StatelessWidget {
  static const id = "StatsMenu";
  final OurGame game;
  const StatsMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withAlpha(100),
        body: Center(
          child: Card(
              color: Colors.green,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    GestureDetector(
                      onTap: () =>
                          {game.resume(), game.overlays.remove(StatsMenu.id)},
                      child: const Text("Close",
                          style: TextStyle(
                              fontSize: 30, backgroundColor: Colors.red)),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "Stats",
                        style: TextStyle(
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            foreground: Paint()..color = Colors.white),
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      StatSection(
                          title: "Health",
                          value: game.deltaHealth.toStringAsFixed(3),
                          data: game.dataPoints["health"]!),
                      StatSection(
                          title: "Morale",
                          value: game.deltaMorale.toStringAsFixed(2),
                          data: game.dataPoints["morale"]!),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      StatSection(
                          title: "CO2 Control",
                          value: game.deltaCarbon.toStringAsFixed(2),
                          data: game.dataPoints["carbon"]!),
                      StatSection(
                          title: "Resources",
                          value: game.deltaResources.toStringAsFixed(2),
                          data: game.dataPoints["resources"]!),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      StatSection(
                          title: "Energy",
                          value: game.deltaEnergy.toStringAsFixed(2),
                          data: game.dataPoints["energy"]!),
                      StatSection(
                          title: "Capital",
                          value: (game.deltaCapital.toStringAsFixed(2)),
                          data: game.dataPoints["capital"]!),
                    ]),
                  ]))),
        ));
  }
}

class StatSection extends StatelessWidget {
  const StatSection(
      {super.key,
      required this.title,
      required this.value,
      required this.data});

  final String title;
  final String value;
  final List<FlSpot> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(children: [
          Card(
              color: Colors.green.shade800,
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Card(
                      color: Colors.green.shade900,
                      child: Column(children: [
                        Text(title,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white)),
                        Text(value),
                      ]),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 16, left: 6),
                      child: LineChart(LineChartData(lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                          spots: data,
                        )
                      ]))),
                ),
              ]))
        ]));
  }
}
