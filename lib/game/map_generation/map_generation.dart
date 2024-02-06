import 'dart:math';

import 'package:fast_noise/fast_noise.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_name/game/map_generation/tile_data.dart';

class MapGenerator {
  MapGenerator(
      {required this.width, required this.height, required this.density});

  final int width;
  final int height;
  final double density;
  final Random _random = Random();
  final PerlinNoise _noise = PerlinNoise(seed: Random().nextInt(1337), frequency: 0.15);

  static const _max = 0.5; // maximum noise value
  static const _min = -_max; // minimum noise value

  List<List<Gid>> generateMapWithGid() {
    final mapData = generateMap();
    final grid = List<List<Gid>>.generate(
        height,
        (i) => List<Gid>.generate(
              width,
              (j) => Gid.fromInt(mapData[i][j].type.id),
            ));

    return grid;
  }

  List<List<TileData>> generateMap() {
    final grid = generatePerlinNoiseMap();
    return grid;
  }

  // List<List<TileData>> applyCellularAutomation(List<List<TileData>> grid) {
  //   const iterationCount = 5;
  //   for (var count = 0; count < iterationCount; count++) {
  //     var tempGrid = List.generate(grid.length, (_) => []);
  //     for (var i = 0; i < grid.length; i++) {
  //       tempGrid[i] = [...grid[i]];
  //     }
  //
  //     for (var i = 0; i < grid.length; i++) {
  //       for (var j = 0; j < grid[0].length; j++) {
  //         var neighborCount = 0;
  //         for (var x = i - 1; x <= i + 1; x++) {
  //           for (var y = j - 1; y <= j + 1; y++) {
  //             if (x >= 0 && x < grid.length && y >= 0 && y < grid[0].length) {
  //               if (x != i || y != j) {
  //                 if (grid[x][y].type == TileType.water) {
  //                   neighborCount++;
  //                 }
  //               }
  //             } else {
  //               neighborCount++;
  //             }
  //           }
  //         }
  //
  //         if (neighborCount > 4) {
  //           grid[i][j] = TileData(type: TileType.water);
  //         } else {
  //           grid[i][j] = TileData(type: TileType.grassLand);
  //         }
  //       }
  //     }
  //   }
  //   return grid;
  // }

  List<List<TileData>> generatePerlinNoiseMap() {
    final grid = List<List<TileData>>.generate(
        height,
        (i) => List<TileData>.generate(
              width,
              (j) {
                var noise = _noise.getNoise2(i.toDouble(), j.toDouble());
                var percentage = (noise - _min) / (_max - _min);
                if (percentage < density) {
                  return TileData(type: TileType.grassLand);
                } else {
                  return TileData(type: TileType.water);
                }
              },
            ));
    return grid;
  }

  List<List<TileData>> generateNoiseMap() {
    final grid = List<List<TileData>>.generate(
        height,
        (i) => List<TileData>.generate(
              width,
              (j) {
                if (_random.nextDouble() < density) {
                  return TileData(type: TileType.grassLand);
                } else {
                  return TileData(type: TileType.water);
                }
              },
            ));

    return grid;
  }
}
