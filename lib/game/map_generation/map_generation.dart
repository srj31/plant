import 'dart:math';
import 'package:fast_noise/fast_noise.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_name/game/map_generation/tile_data.dart';
import 'package:game_name/game/our_game.dart';

class MapGenerator {
  MapGenerator(
      {required this.width,
      required this.height,
      required this.density,
      required this.treeDensity});

  final int width;
  final int height;
  final double density;
  final double treeDensity;
  final Random _random = Random();
  final PerlinNoise _noise =
      PerlinNoise(seed: Random().nextInt(1337), frequency: 0.15);

  final SimplexFractalNoise _noiseSimplex = SimplexFractalNoise(
    octaves: 4,
    frequency: 0.5,
    seed: Random().nextInt(1337),
  );

  static const _max = 1; // maximum noise value
  static const _min = -_max; // minimum noise value

  static const _maxTree = 0.5; // maximum noise value
  static const _minTree = -_maxTree; // minimum noise value

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

  List<Vector2> generateTreeLocations(List<List<Gid>> grid, int count) {
    List<Vector2> treeLocations = [];
    for (var i = 0; i < height; i++) {
      for (var j = 0; j < width; j++) {
        if (grid[i][j].tile == TileType.grassLand.id) {
          var noise = _noiseSimplex.getNoise2(i.toDouble(), j.toDouble());
          var percentage = (noise - _minTree) / (_maxTree - _minTree);
          if (percentage < treeDensity && count > 0) {
            count--;
            treeLocations.add(Vector2(i.toDouble(), j.toDouble()));
          }
        }
      }
    }

    return treeLocations;
  }

  List<Vector2> generateBuildingLocations(List<List<Gid>> grid, int count,
      {required OurGame game, required int xOffset, required int yOffset}) {
    List<Vector2> buildingLocations = [];
    final nonEmptyTiles = game.getNonEmptyTiles();
    for (var i = 0; i < height; i++) {
      for (var j = 0; j < width; j++) {
        if (grid[i][j].tile == TileType.grassLand.id &&
            nonEmptyTiles[i + xOffset][j + yOffset] == false) {
          var noise = _noiseSimplex.getNoise2(i.toDouble(), j.toDouble());
          var percentage = (noise - _min) / (_max - _min);
          if (percentage < treeDensity && count > 0) {
            count--;
            buildingLocations.add(Vector2(i.toDouble(), j.toDouble()));
          }
        }
      }
    }

    return buildingLocations;
  }

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
