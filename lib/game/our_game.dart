import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:game_name/game/misc_structures/tree.dart';
import 'package:game_name/game/overlays/build.dart';
import 'package:game_name/game/overlays/event.dart';
import 'package:game_name/game/overlays/game_over.dart';
import 'package:game_name/game/overlays/next_level.dart';
import 'package:game_name/game/overlays/non_green.dart';
import 'package:game_name/game/overlays/policies.dart';
import 'package:game_name/game/overlays/research.dart';
import 'package:game_name/game/overlays/specialization.dart';
import 'package:game_name/game/specializations/specialization.dart';
import 'package:game_name/game/state/default.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/util/hex.dart';
import 'overlays/hud.dart';
import 'tile_info.dart';

class OurGame extends FlameGame with TapCallbacks, ScaleDetector {
  late TiledComponent mapComponent;
  late BuildComponent buildComponent;

  late Sprite capitalSprite;
  late Sprite moraleSprite;
  late Sprite carbonEmissionSprite;
  late Sprite energySprite;
  late Sprite resourcesSprite;

  late Sprite evFactory;
  late Sprite windmill;
  late Sprite recyclingFactory;
  late Sprite greenHydrogen;
  late Sprite publicTransport;
  late Sprite carbonTax;
  late Sprite afforestation;
  late Sprite globalTreaty;
  late Sprite carbonTechnology;
  late Sprite smartGrid;
  late Sprite biodegradable;
  late Sprite nanoTechnology;
  late Sprite fossilFuel;
  late Sprite deforestation;
  late Sprite plastic;
  late Sprite wasteIncineration;

  late Sprite house;

  late Sprite technologySpecialization;
  late Sprite policySpecialization;
  late Sprite researchSpecialization;

  late Sprite earthquake;
  late Sprite forrestFire;

  late Specialization specialization;

  late Structure toAdd;
  late Timer interval;
  late Structure selectedStructure;

  late List<List<Gid>> cachedTiledData;

  int elapsedSecs = 0;
  AbstractState state = DefaultState();

  bool hasTimerStarted = false;
  static const double _minZoom = 0.3;
  static const double _maxZoom = 1.0;
  double _startZoom = _minZoom;
  double health = 40;
  double morale = 75;
  double carbonEmission = 20;
  double resources = 500;
  double energy = 70;
  double capital = 1000;

  double deltaHealth = 0;
  double deltaMorale = 0;
  double deltaCarbon = 0;
  double deltaResources = 0;
  double deltaEnergy = 0;
  double deltaCapital = 0;

  List<Structure> builtItems = [];
  List<Tree> trees = [];

  void addBuiltItem({required Structure item, bool isPreBuilt = false}) {
    world.add(item);
    if (!isPreBuilt) {
      capital -= item.capital;
      resources -= item.resources;
    }

    deltaHealth += item.deltaHealth;
    deltaMorale += item.deltaMorale;
    deltaCarbon += item.deltaCarbon;
    deltaResources += item.deltaResources;
    deltaEnergy += item.deltaEnergy;
    deltaCapital += item.deltaCapital;

    builtItems.add(item);
  }

  void removeBuiltItem(int index) {
    final item = builtItems[index];
    deltaHealth -= item.deltaHealth;
    deltaMorale -= item.deltaMorale;
    deltaCarbon -= item.deltaCarbon;
    deltaResources -= item.deltaResources;
    deltaEnergy -= item.deltaEnergy;
    deltaCapital -= item.deltaCapital;
    world.remove(item);
    builtItems.removeAt(index);
  }

  void removeTree(int index) {
    final tree = trees[index];
    world.remove(tree);
    trees.removeAt(index);
  }

  List<List<bool>> getNonEmptyTiles() {
    final tileSize = mapComponent.tileMap.destTileSize;
    final rows = mapComponent.width;
    final cols = mapComponent.height;
    final grid = List<List<bool>>.generate(
        rows.floor(),
        (i) => List<bool>.generate(cols.floor(), (index) => false,
            growable: false),
        growable: false);

    final size = Vector2(tileSize.x / math.sqrt(3), tileSize.y / 2);
    final origin = Vector2(size.x * math.sqrt(3) / 2, size.y);
    final Layout layout = Layout(layout_pointy, size, origin);
    for (final item in builtItems) {
      final pos = item.position;
      final rowAndCol = pixelToOffset(layout, pos);
      grid[rowAndCol.x.floor()][rowAndCol.y.floor()] = true;
    }

    for (final tree in trees) {
      final pos = tree.position;
      final rowAndCol = pixelToOffset(layout, pos);
      grid[rowAndCol.x.floor()][rowAndCol.y.floor()] = true;
    }

    return grid;
  }

  void populateTrees({required Tree tree, bool isPreBuilt = false}) async {
    world.add(tree);
    deltaHealth += tree.deltaHealth;
    deltaMorale += tree.deltaMorale;
    deltaCarbon += tree.deltaCarbon;
    deltaResources += tree.deltaResources;
    deltaEnergy += tree.deltaEnergy;
    deltaCapital += tree.deltaCapital;

    trees.add(tree);
  }

  void _calculateDeltaHealth() {
    deltaHealth = -carbonEmission / 100;
  }

  @override
  Color backgroundColor() =>
      const Color(0x00000000); // Must be transparent to show the background

  @override
  Future<void> onLoad() async {
    camera.viewfinder
      ..zoom = _startZoom
      ..position = Vector2(0, 0)
      ..anchor = Anchor.topLeft;

    mapComponent = await TiledComponent.load(
      'game.tmx',
      Vector2(120, 140),
    );

    await Flame.images.load("hexagonObjects_sheet.png");
    world.add(mapComponent);
    await initializeGame();
  }

  Future<void> initializeGame() async {
    await _loadSprites();
    final tiledData =
        mapComponent.tileMap.getLayer<TileLayer>("Map")!.tileData!;

    cachedTiledData = List.generate(tiledData.length, (_) => []);

    for (var i = 0; i < tiledData.length; i++) {
      cachedTiledData[i] = [...tiledData[i]];
    }

    final trees = mapComponent.tileMap.getLayer<ObjectGroup>("trees")!;
    final buildings = mapComponent.tileMap.getLayer<ObjectGroup>("buildings")!;

    for (final tree in trees.objects) {
      populateTrees(
          tree: Tree(
              position: Vector2(tree.x, tree.y + tree.height / 2),
              priority: 1,
              anchor: Anchor.center)
            ..current = BuildingState.done
            ..timeLeft = 0,
          isPreBuilt: true);
    }

    for (final building in buildings.objects) {
      final structure = Structure.factory(building);
      addBuiltItem(
          item: structure
            ..current = BuildingState.done
            ..timeLeft = 0,
          isPreBuilt: true);
    }

    interval = Timer(2, onTick: () {
      _calculateDeltaHealth();
      elapsedSecs += 1;
      health = math.max(
          0,
          health +
              deltaHealth -
              (1 - 0.01 * carbonEmission) -
              (1 - 0.02 * resources));
      energy = math.max(0, energy + deltaEnergy);
      carbonEmission = math.max(0, carbonEmission + deltaCarbon);
      resources = math.max(0, resources + deltaResources);
      capital = math.max(0, capital + deltaCapital);
      morale = math.max(0, morale + deltaMorale);
      if (health <= 0) {
        overlays.add(GameOverMenu.id);
        hasTimerStarted = false;
      }
      if (health >= 100) {
        overlays.add(NextLevelMenu.id);
        hasTimerStarted = false;
      }

      if (elapsedSecs % 1000 == 0) {
        overlays.add(EventMenu.id);
        hasTimerStarted = false;
      }
    }, repeat: true);

    camera.viewport.add(buildComponent);
    camera.viewport.add(ResearchComponent());
    camera.viewport.add(PoliciesComponent());
    camera.viewport.add(NonGreenComponent());
    camera.viewport.add(Hud());
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;

    if (currentScale.isIdentity()) {
      // One-finger gesture
      _processDrag(info);
    } else {
      // Several fingers gesture
      _processScale(info, currentScale);
    }
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    _checkScaleBorders();
    _checkDragBorders();
  }

  @override
  void onTapDown(TapDownEvent event) {
    getTappedCell(event);
    state.handleTap(this, event);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (hasTimerStarted) {
      interval.update(dt);
    }
  }

  void nextLevel() {
    overlays.add(SpecializationMenu.id);
    elapsedSecs = 0;
    state = DefaultState();

    hasTimerStarted = false;
    _startZoom = _minZoom;
    health = 2;
    morale = 30;
    carbonEmission = 2;
    resources = 100;
    energy = 40;
    capital = 1000;

    deltaHealth = 20;
    deltaMorale = -0.5;
    deltaCarbon = -0.5;
    deltaResources = -0.5;
    deltaEnergy = -0.5;
    deltaCapital = -10;

    world.removeAll(builtItems);
    world.removeAll(trees);
    builtItems = [];
    trees = [];
  }

  void setSpecialization(Specialization specialization) {
    this.specialization = specialization;
    capital *= specialization.factorCapital;
    resources *= specialization.factorResources;
    energy *= specialization.factorEnergy;
    carbonEmission *= specialization.factorCarbon;
    morale *= specialization.factorMorale;
  }

  Future<void> _loadSprites() async {
    capitalSprite = getObjectSprite(58, 488, 22, 20);
    carbonEmissionSprite = getObjectSprite(510, 485, 18, 24);
    energySprite = getObjectSprite(990, 64, 18, 28);
    resourcesSprite = getObjectSprite(0, 488, 28, 21);
    moraleSprite = getObjectSprite(944, 0, 22, 30);

    buildComponent = BuildComponent();
    evFactory = Sprite(await Flame.images.load("ev_factory.png"));
    windmill = Sprite(await Flame.images.load("windmill.png"));
    recyclingFactory = Sprite(await Flame.images.load("recycling_factory.png"));
    greenHydrogen = Sprite(await Flame.images.load("green_hydrogen.png"));

    publicTransport = getObjectSprite(216, 0, 86, 94);
    carbonTax = getObjectSprite(970, 128, 18, 37);
    afforestation = Sprite(await Flame.images.load("grass_13.png"));
    globalTreaty = getObjectSprite(386, 75, 74, 70);

    carbonTechnology = getObjectSprite(908, 90, 30, 56);
    smartGrid = getObjectSprite(532, 0, 68, 98);
    biodegradable = getObjectSprite(601, 100, 56, 62);
    nanoTechnology = getObjectSprite(712, 433, 50, 50);

    fossilFuel = Sprite(await Flame.images.load("fossil.png"));
    deforestation = getObjectSprite(862, 248, 36, 32);
    plastic = Sprite(await Flame.images.load("plastic.png"));
    wasteIncineration = Sprite(await Flame.images.load("waste.png"));

    house = Sprite(await Flame.images.load("modern_villa.png"));

    earthquake = Sprite(await Flame.images.load("earthquake.png"));
    forrestFire = Sprite(await Flame.images.load("forrest_fire.png"));

    technologySpecialization = getObjectSprite(904, 437, 34, 41);
    policySpecialization = getObjectSprite(382, 319, 76, 76);
    researchSpecialization = getObjectSprite(594, 384, 58, 108);
  }

  void _processDrag(ScaleUpdateInfo info) {
    final delta = info.delta.global;
    final zoomDragFactor = 1.0 /
        _startZoom; // To synchronize a drag distance with current zoom value
    final currentPosition = camera.viewfinder.position;

    camera.viewfinder.position = currentPosition.translated(
      -delta.x * zoomDragFactor,
      -delta.y * zoomDragFactor,
    );
  }

  void _processScale(ScaleUpdateInfo info, Vector2 currentScale) {
    final newZoom = _startZoom * ((currentScale.y + currentScale.x) / 2.0);
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
  }

  void _checkScaleBorders() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void _checkDragBorders() {
    final worldRect = camera.visibleWorldRect;

    final currentPosition = camera.viewfinder.position;

    final mapSize = Offset(mapComponent.width, mapComponent.height);

    var xTranslate = 0.0;
    var yTranslate = 0.0;

    if (worldRect.topLeft.dx < 0.0) {
      xTranslate = -worldRect.topLeft.dx;
    } else if (worldRect.bottomRight.dx > mapSize.dx) {
      xTranslate = mapSize.dx - worldRect.bottomRight.dx;
    }

    if (worldRect.topLeft.dy < 0.0) {
      yTranslate = -worldRect.topLeft.dy;
    } else if (worldRect.bottomRight.dy > mapSize.dy) {
      yTranslate = mapSize.dy - worldRect.bottomRight.dy;
    }

    camera.viewfinder.position =
        currentPosition.translated(xTranslate, yTranslate);
  }

  TileInfo getTappedCell(TapDownEvent event) {
    final clickOnMapPoint = camera.globalToLocal(event.localPosition);
    final tileSize = mapComponent.tileMap.destTileSize;

    final size = Vector2(tileSize.x / math.sqrt(3), tileSize.y / 2);
    final origin = Vector2(size.x * math.sqrt(3) / 2, size.y);
    final Layout layout = Layout(layout_pointy, size, origin);

    final rowAndCol = pixelToOffset(layout, clickOnMapPoint);
    final targetHex = pixelToHex(layout, clickOnMapPoint);
    final targetCenter = hexToPixel(layout, targetHex);

    return TileInfo(
        center: targetCenter,
        row: rowAndCol.x.floor(),
        col: rowAndCol.y.floor());
  }

  Sprite getObjectSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('hexagonObjects_sheet.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }
}
