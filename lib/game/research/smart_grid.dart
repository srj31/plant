import 'package:game_name/game/research/researh.dart';

class SmartGrid extends Research {
  SmartGrid(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 500,
            resources: 40,
            deltaCapital: -0.1,
            deltaResources: 0.2,
            deltaCarbon: 0.05,
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.05,
            timeToImplement: 4,
            id: 'smart_grid');

  static const name = 'smart_grid';
  @override
  Future<void> onLoad() async {
    sprite = game.smartGrid;
    await super.onLoad();
  }
}
