import "dart:math" as math;
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/structures/structures.dart';

class PopupManager {
  static void showPopup(OurGame game) {
    if (game.hasTimerStarted == false) return;

    if (game.elapsedSecs % 7 == 0) {
      if (math.Random().nextDouble() < 0.9) {
        for (int i = 0; i < 3; i++) {
          int len = game.trees.length;
          if (len > 0) {
            int index = math.Random().nextInt(len);
            Structure structure = game.trees[index];
            structure.displayBubble();
          }
        }
      }

      if (math.Random().nextDouble() < 0.7) {
        for (int i = 0; i < 2; i++) {
          int len = game.trees.length;
          if (len > 0) {
            int index = math.Random().nextInt(len);
            Structure structure = game.trees[index];
            structure.displayTextPopup();
          }
        }
      }
      if (math.Random().nextDouble() < 0.7) {
        for (int i = 0; i < 3; i++) {
          int len = game.builtItems.length;
          if (len > 0) {
            int index = math.Random().nextInt(len);
            Structure structure = game.builtItems[index];
            structure.displayBubble();
          }
        }
      }

      if (math.Random().nextDouble() < 0.7) {
        for (int i = 0; i < 2; i++) {
          int len = game.builtItems.length;
          if (len > 0) {
            int index = math.Random().nextInt(len);
            Structure structure = game.builtItems[index];
            structure.displayTextPopup();
          }
        }
      }
    }
  }
}
