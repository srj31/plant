import 'package:fl_chart/fl_chart.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';
import 'package:google_fonts/google_fonts.dart';

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
    sprite = Sprite(await Flame.images.load('stats.png'));
    position = Vector2(game.size.x * 0.9, game.size.y * 0.25);
    size = Vector2.all(32);
    priority = 2;
    anchor = Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.hasTimerStarted) game.pause();
    game.overlays.add(StatsMenu.id);
  }
}

class StatsMenu extends StatelessWidget {
  static const id = "StatsMenu";
  final OurGame game;
  const StatsMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black.withAlpha(100),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              child: GestureDetector(
                onTap: () =>
                    {game.resume(), game.overlays.remove(StatsMenu.id)},
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Container(
                    width: 50,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.brown.shade700,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                            offset: const Offset(1.0, 1.0),
                          ),
                        ]),
                    child: const Center(
                      child: Text("Back",
                          style: TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.05),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatSection(
                                imagePath: "health.png",
                                title: "Health",
                                value: game.paramDelta.deltaHealth
                                    .toStringAsFixed(3),
                                data: game.dataPoints["health"]!),
                            StatSection(
                                imagePath: "morale.png",
                                title: "Morale",
                                value: game.paramDelta.deltaMorale
                                    .toStringAsFixed(2),
                                data: game.dataPoints["morale"]!),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatSection(
                                imagePath: "carbonControl.png",
                                title: "CO2 Control",
                                value: game.paramDelta.deltaCarbon
                                    .toStringAsFixed(2),
                                data: game.dataPoints["carbon"]!),
                            StatSection(
                                imagePath: "resources.png",
                                title: "Resources",
                                value: game.paramDelta.deltaResources
                                    .toStringAsFixed(2),
                                data: game.dataPoints["resources"]!),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            StatSection(
                                imagePath: "energy.png",
                                title: "Energy",
                                value: game.paramDelta.deltaEnergy
                                    .toStringAsFixed(2),
                                data: game.dataPoints["energy"]!),
                            StatSection(
                                imagePath: "capital.png",
                                title: "Capital",
                                value: (game.paramDelta.deltaCapital
                                    .toStringAsFixed(2)),
                                data: game.dataPoints["capital"]!),
                          ]),
                    ])),
              ),
            ),
          ],
        )));
  }
}

class StatSection extends StatelessWidget {
  const StatSection(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.value,
      required this.data});

  final String title;
  final String imagePath;
  final String value;
  final List<FlSpot> data;

  // final List<FlSpot> defaultData = const [
  //   FlSpot(0, 3),
  //   FlSpot(2.6, 2),
  //   FlSpot(4.9, 5),
  //   FlSpot(6.8, 3.1),
  //   FlSpot(8, 4),
  //   FlSpot(9.5, 3),
  //   FlSpot(10, -2),
  //   FlSpot(11, 4),
  // ];

  final List<Color> gradientColors = const [
    Colors.lightGreen,
    Colors.lightGreen
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        width: width * 0.45,
        height: height * 0.55,
        child: Stack(children: [
          Card(
              color: Colors.black26,
              child: Row(children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.green,
                            Colors.lightGreen,
                            Colors.green.shade600
                          ],
                        ),
                      ),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.01),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.45 * 0.25,
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                color: Colors.green),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/$imagePath',
                                  width: 32,
                                  height: 32,
                                ),
                                Text(title,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily:
                                            GoogleFonts.play().fontFamily)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.01,
                              vertical: height * 0.01),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.green.shade800),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    const Text("Delta"),
                                    Text(value,
                                        style: const TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.green.shade800),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    const Text("Min."),
                                    Text(
                                        data
                                            .fold(
                                                const FlSpot(double.infinity,
                                                    double.infinity),
                                                (cur, next) =>
                                                    cur.y < next.y ? cur : next)
                                            .y
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.green.shade800),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    const Text("Max."),
                                    Text(
                                        data
                                            .fold(
                                                const FlSpot(0, 0),
                                                (cur, next) =>
                                                    cur.y > next.y ? cur : next)
                                            .y
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, top: 10, bottom: 10),
                      child: LineChart(LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            aboveBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [Colors.red, Colors.orange]
                                    .map((color) => color.withOpacity(0.4))
                                    .toList(),
                              ),
                              cutOffY: 0.0,
                              applyCutOffY: true,
                            ),
                            isCurved: true,
                            barWidth: 2,
                            isStrokeCapRound: true,
                            color: Colors.green.shade700,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              cutOffY: 0.0,
                              gradient: LinearGradient(
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.4))
                                    .toList(),
                              ),
                              applyCutOffY: true,
                            ),
                            spots: data,
                          )
                        ],
                        titlesData: const FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 42,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: const Color(0xff37434d)),
                        ),
                      ))),
                ),
              ]))
        ]));
  }
}
