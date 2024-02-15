import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

// This class is responsible for playing all the sound effects
// and background music in this game.
class AudioManager {
  static final sfx = ValueNotifier(true);
  static final bgm = ValueNotifier(false);

  static Future<void> init() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'game_over.wav',
      'opening_overlay.wav',
      'when_built.wav',
      'on_construction.wav',
      'tap_bubble.wav',
      'game_menu.wav'
    ]);
  }

  static void playSfx(String file, double volume) {
    if (sfx.value) {
      FlameAudio.play(file, volume: volume);
    }
  }

  static void playBgm(String file, double volume) {
    if (bgm.value) {
      FlameAudio.bgm.play(file, volume: volume);
    }
  }

  static void pauseBgm() {
    FlameAudio.bgm.pause();
  }

  static void resumeBgm() {
    if (bgm.value) {
      FlameAudio.bgm.resume();
    }
  }

  static void stopBgm() {
    FlameAudio.bgm.stop();
  }
}
