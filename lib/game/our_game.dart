import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:game_name/game/non_green/fossil_fuel.dart';
import 'package:game_name/game/overlays/build.dart';
import 'package:game_name/game/overlays/non_green.dart';
import 'package:game_name/game/overlays/policies.dart';
import 'package:game_name/game/overlays/research.dart';
import 'package:game_name/game/policies/afforestation.dart';
import 'package:game_name/game/policies/policy.dart';
import 'package:game_name/game/specializations/specialization.dart';
import 'package:game_name/game/state/default.dart';
import 'package:game_name/game/structures/ev_factory.dart';
import 'package:game_name/game/structures/green_hydrogen.dart';
import 'package:game_name/game/structures/recycling_factory.dart';
import 'package:game_name/game/structures/structures.dart';
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

  late Sprite technologySpecialization;
  late Sprite policySpecialization;
  late Sprite researchSpecialization;

  late Specialization specialization;

  late Structure toAdd;
  late Timer interval;
  late Structure selectedStructure;

  int elapsedSecs = 0;
  AbstractState state = DefaultState();

  bool hasTimerStarted = false;
  static const double _minZoom = 0.3;
  static const double _maxZoom = 2.0;
  double _startZoom = _minZoom;
  double health = 20;
  double morale = 75;
  double carbonEmission = 20;
  double resources = 10000;
  double energy = 70;
  double capital = 1000000;

  double deltaHealth = -0.5;
  double deltaMorale = -0.5;
  double deltaCarbon = -0.5;
  double deltaResources = -0.5;
  double deltaEnergy = -0.5;
  double deltaCapital = -10;

  final List<Structure> _builtItems = [];

  void addBuiltItem(Structure item) {
    world.add(item);
    capital -= item.capital;
    resources -= item.resources;
    deltaHealth += item.deltaHealth;
    deltaMorale += item.deltaMorale;
    deltaCarbon += item.deltaCarbon;
    deltaResources += item.deltaResources;
    deltaEnergy += item.deltaEnergy;
    deltaCapital += item.deltaCapital;

    _builtItems.add(item);
  }

  void populateTrees(Policy item) {
    world.add(item);
    deltaHealth += item.deltaHealth;
    deltaMorale += item.deltaMorale;
    deltaCarbon += item.deltaCarbon;
    deltaResources += item.deltaResources;
    deltaEnergy += item.deltaEnergy;
    deltaCapital += item.deltaCapital;
  }

  @override
  Color backgroundColor() =>
      const Color(0x00000000); // Must be transparent to show the background

  @override
  Future<void> onLoad() async {
    camera.viewfinder
      ..zoom = _startZoom
      ..anchor = Anchor.topLeft;

    mapComponent = await TiledComponent.load(
      'game.tmx',
      Vector2(120, 140),
    );

    await Flame.images.load("hexagonObjects_sheet.png");
    world.add(mapComponent);

    initializeGame();
  }

  void initializeGame() {
    _loadSprites();

    final trees = mapComponent.tileMap.getLayer<ObjectGroup>("trees")!;
    final buildings = mapComponent.tileMap.getLayer<ObjectGroup>("buildings")!;

    for (final tree in trees.objects) {
      populateTrees(Afforestation(
          position: Vector2(tree.x, tree.y),
          priority: 1,
          anchor: Anchor.topLeft));
    }

    for (final building in buildings.objects) {
      if (building.properties["type"]!.value == "house") {
        addBuiltItem(GreenHydrogen(
            position: Vector2(building.x, building.y),
            priority: 1,
            anchor: Anchor.topLeft));
      } else if (building.properties["type"]!.value == "fossil") {
        addBuiltItem(FossilFuel(
            position: Vector2(building.x, building.y),
            priority: 1,
            anchor: Anchor.topLeft));
      }
    }

    interval = Timer(1, onTick: () {
      elapsedSecs += 1;
      health = math.max(0, health + deltaHealth);
      energy = math.max(0, energy + deltaEnergy);
      carbonEmission = math.max(0, carbonEmission + deltaCarbon);
      resources = math.max(0, resources + deltaResources);
      capital = math.max(0, capital + deltaCapital);
      morale = math.max(0, morale + deltaMorale);
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
    state.handleTap(this, event);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (hasTimerStarted) {
      interval.update(dt);
    }
  }

  void setSpecialization(Specialization specialization) {
    this.specialization = specialization;
    capital *= specialization.factorCapital;
    resources *= specialization.factorResources;
    energy *= specialization.factorEnergy;
    carbonEmission *= specialization.factorCarbon;
    morale *= specialization.factorMorale;
  }

  void _loadSprites() {
    capitalSprite = getObjectSprite(58, 488, 22, 20);
    carbonEmissionSprite = getObjectSprite(510, 485, 18, 24);
    energySprite = getObjectSprite(990, 64, 18, 28);
    resourcesSprite = getObjectSprite(0, 488, 28, 21);
    moraleSprite = getObjectSprite(944, 0, 22, 30);

    buildComponent = BuildComponent();
    evFactory = getObjectSprite(120, 0, 94, 84);
    windmill = getObjectSprite(712, 128, 52, 66);
    recyclingFactory = getObjectSprite(532, 190, 66, 76);
    greenHydrogen = getObjectSprite(600, 190, 56, 62);
    publicTransport = getObjectSprite(216, 0, 86, 94);
    carbonTax = getObjectSprite(970, 128, 18, 37);
    afforestation = getObjectSprite(969, 343, 20, 46);
    globalTreaty = getObjectSprite(386, 75, 74, 70);
    carbonTechnology = getObjectSprite(908, 90, 30, 56);
    smartGrid = getObjectSprite(532, 0, 68, 98);
    biodegradable = getObjectSprite(601, 100, 56, 62);
    nanoTechnology = getObjectSprite(712, 433, 50, 50);
    fossilFuel = getObjectSprite(864, 58, 42, 53);
    deforestation = getObjectSprite(862, 248, 36, 32);
    plastic = getObjectSprite(766, 0, 48, 48);
    wasteIncineration = getObjectSprite(970, 128, 18, 37);

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

    final rows = mapComponent.tileMap.map.width;
    final cols = mapComponent.tileMap.map.height;

    final tileSize = mapComponent.tileMap.destTileSize;

    var targetRow = 0;
    var targetCol = 0;
    var minDistance = double.maxFinite;
    var targetCenter = Offset.zero;

    for (var row = 0; row < rows; row++) {
      for (var col = 0; col < cols; col++) {
        final xCenter = col * tileSize.x +
            tileSize.x / 2 +
            (row.isEven ? 0 : tileSize.x / 2);
        final yCenter =
            row * tileSize.y - (row * tileSize.y / 4) + tileSize.y / 2;

        final distance = math.sqrt(math.pow(xCenter - clickOnMapPoint.x, 2) +
            math.pow(yCenter - clickOnMapPoint.y, 2));

        if (distance < minDistance) {
          minDistance = distance;
          targetRow = row;
          targetCol = col;
          targetCenter = Offset(xCenter, yCenter);
        }
      }
    }

    return TileInfo(center: targetCenter, row: targetRow, col: targetCol);
  }

  Sprite getObjectSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('hexagonObjects_sheet.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }
}
