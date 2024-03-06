import 'dart:collection';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/map_generation/map_generation.dart';
import 'package:game_name/game/misc/background.dart';
import 'package:game_name/game/misc_structures/tree.dart';
import 'package:game_name/game/overlays/banner.dart';
import 'package:game_name/game/overlays/build.dart';
import 'package:game_name/game/overlays/event.dart';
import 'package:game_name/game/overlays/game_over.dart';
import 'package:game_name/game/overlays/next_level.dart';
import 'package:game_name/game/overlays/non_green.dart';
import 'package:game_name/game/overlays/pause.dart';
import 'package:game_name/game/overlays/policies.dart';
import 'package:game_name/game/overlays/research.dart';
import 'package:game_name/game/overlays/specialization.dart';
import 'package:game_name/game/overlays/stats.dart';
import 'package:game_name/game/overlays/tutorial.dart';
import 'package:game_name/game/policies/policy.dart';
import 'package:game_name/game/research/researh.dart';
import 'package:game_name/game/specializations/specialization.dart';
import 'package:game_name/game/state/default.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';
import 'package:game_name/util/delta.dart';
import 'package:game_name/util/hex.dart';
import 'overlays/hud.dart';
import 'tile_info.dart';

class OurGame extends FlameGame with TapCallbacks, ScaleDetector {
  OurGame({this.isTutorial = false});

  final bool isTutorial;
  late TiledComponent mapComponent;
  late BuildComponent buildComponent;
  late PausePlayComponent pauseComponent;
  late SpriteComponent noPower;

  late Sprite capitalSprite;
  late Sprite moraleSprite;
  late Sprite carbonEmissionSprite;
  late Sprite energySprite;
  late Sprite resourcesSprite;

  late SpriteAnimation evFactory;
  late SpriteAnimation windmill;
  late SpriteAnimation recyclingFactory;
  late SpriteAnimation greenHydrogen;
  late Sprite publicTransport;
  late Sprite carbonTax;
  late Sprite afforestation;
  late Sprite globalTreaty;
  late Sprite carbonTechnology;
  late Sprite smartGrid;
  late Sprite biodegradable;
  late Sprite nanoTechnology;
  late SpriteAnimation fossilFuel;
  late SpriteAnimation deforestation;
  late SpriteAnimation plastic;
  late SpriteAnimation wasteIncineration;

  late SpriteAnimation house;
  late SpriteAnimation tree;
  late SpriteAnimation underConstruction;

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
  bool playSounds = true;
  double soundVolume = 1.0;

  double temperature = 25.0;
  double windSpeed = 1.0;

  bool powerShortage = false;

  Size deviceSize = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  bool hasTimerStarted = false;
  static const double _minZoom = 0.5;
  static const double _maxZoom = 1.0;
  final MapGenerator _mapGenerator =
      MapGenerator(width: 10, height: 5, density: 0.62, treeDensity: 0.5);
  double _startZoom = _minZoom;
  double health = 40;
  double morale = 0;
  double carbonEmission = 20;
  double resources = 100;
  double energy = 0;
  double capital = 1000;

  ParamDelta paramDelta = ParamDelta(
      deltaHealth: -0.1,
      deltaMorale: 0,
      deltaCarbon: 0,
      deltaResources: 0,
      deltaEnergy: 0,
      deltaCapital: 0);

  ParamDelta bonus = ParamDelta.zero();

  List<Structure> builtItems = [];
  List<TreeStructure> trees = [];
  Queue<(double, Structure)> inProgressStructures =
      Queue<(double, Structure)>();
  Queue<(double, Policy)> inProgressPolicies = Queue<(double, Policy)>();
  Queue<(double, Research)> inProgressResearches = Queue<(double, Research)>();
  Queue<(double, Upgrade)> inProgressUpgrade = Queue<(double, Upgrade)>();
  Map<String, List<FlSpot>> dataPoints = <String, List<FlSpot>>{
    "health": [],
    "morale": [],
    "carbon": [],
    "resources": [],
    "energy": [],
    "capital": []
  };

  void addBuiltItem({required Structure item, bool isPreBuilt = false}) {
    world.add(item);
    builtItems.add(item);
    if (!isPreBuilt) {
      capital -= item.capital;
      resources -= item.resources;
      inProgressStructures.add((elapsedSecs + item.timeToBuild, item));
    } else {
      paramDelta += item.paramDelta;
    }
  }

  void startPolicy(Policy policy) {
    capital -= policy.capital;
    resources -= policy.resources;
    inProgressPolicies.add((elapsedSecs + policy.timeToPass, policy));
  }

  void startResearch(Research research) {
    capital -= research.capital;
    resources -= research.resources;
    inProgressResearches
        .add((elapsedSecs + research.timeToImplement, research));
  }

  void applyUpgrade(Upgrade upgrade) {
    upgrade.isPurchased = true;
    capital -= upgrade.capital;
    resources -= upgrade.resources;
    inProgressUpgrade.add((elapsedSecs + upgrade.timeToUpgrade, upgrade));
  }

  void removeBuiltItem(int index) {
    final item = builtItems[index];
    paramDelta -= item.paramDelta;
    item.addAll([
      OpacityEffect.fadeOut(
        LinearEffectController(1.5),
        target: item,
        onComplete: () => world.remove(item),
      ),
      ColorEffect(const Color(0xFFFF0000), ZigzagEffectController(period: 1.5))
    ]);
    builtItems.removeAt(index);
  }

  void removeTree(int index) {
    final tree = trees[index];
    tree.addAll([
      OpacityEffect.fadeOut(
        LinearEffectController(1.5),
        target: tree,
        onComplete: () => world.remove(tree),
      ),
      ColorEffect(const Color(0xFFFF0000), ZigzagEffectController(period: 1.5)),
      ScaleEffect.by(Vector2(0.9, 0.9), LinearEffectController(1.5))
    ]);
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

  Future<void> populateTrees(
      {required TreeStructure tree, bool isPreBuilt = false}) async {
    world.add(tree);

    paramDelta += tree.paramDelta;

    trees.add(tree);
  }

  @override
  Color backgroundColor() =>
      const Color(0x00000000); // Must be transparent to show the background

  @override
  Future<void> onLoad() async {
    if (isTutorial) {
      overlays.add(Tutorial.id);
    }
    camera.viewfinder
      ..zoom = _startZoom
      ..position = Vector2(size.x, size.y * 0.8)
      ..anchor = Anchor.center;

    mapComponent = await TiledComponent.load(
      'game.tmx',
      Vector2(120, 140),
    );

    await Flame.images.load("hexagonObjects_sheet.png");
    world.add(mapComponent);
    _scrollingBackground();
    await initializeGame();
  }

  Future<void> initializeGame() async {
    await _loadSprites();
    await AudioManager.init();

    AudioManager.playBgm('game_menu.wav', soundVolume * 0.2);

    _initializeMap();

    final tiledData =
        mapComponent.tileMap.getLayer<TileLayer>("Map")!.tileData!;

    cachedTiledData = List.generate(tiledData.length, (_) => []);

    for (var i = 0; i < tiledData.length; i++) {
      cachedTiledData[i] = [...tiledData[i]];
    }

    interval = Timer(2, onTick: () {
      _updateDataPoints();
      elapsedSecs += 1;
      while (inProgressStructures.isNotEmpty &&
          inProgressStructures.first.$1 <= elapsedSecs) {
        final itemWithTime = inProgressStructures.removeFirst();
        final item = itemWithTime.$2;
        paramDelta += item.paramDelta;
      }

      while (inProgressPolicies.isNotEmpty &&
          inProgressPolicies.first.$1 <= elapsedSecs) {
        final policyWithTime = inProgressPolicies.removeFirst();
        final policy = policyWithTime.$2;
        paramDelta += policy.paramDelta;
      }

      while (inProgressResearches.isNotEmpty &&
          inProgressResearches.first.$1 <= elapsedSecs) {
        final researchWithTime = inProgressResearches.removeFirst();
        final research = researchWithTime.$2;
        paramDelta += research.paramDelta;
      }

      while (inProgressUpgrade.isNotEmpty &&
          inProgressUpgrade.first.$1 <= elapsedSecs) {
        final upgradeWithTime = inProgressUpgrade.removeFirst();
        final upgrade = upgradeWithTime.$2;
        paramDelta += upgrade.paramDelta;
      }

      _bonusCalculation();

      health = math.max(
          0, health + paramDelta.deltaHealth - (1 - 0.001 * carbonEmission));
      energy = math.max(0, energy + paramDelta.deltaEnergy);
      carbonEmission = math.max(0, carbonEmission + paramDelta.deltaCarbon);
      resources = math.max(0, resources + paramDelta.deltaResources);
      capital = math.max(0, capital + paramDelta.deltaCapital);
      morale = math.max(0, morale + paramDelta.deltaMorale);
      if (health <= 0) {
        overlays.add(GameOverMenu.id);
        AudioManager.playSfx('game_over.wav', soundVolume);
        hasTimerStarted = false;
      }
      if (health >= 100) {
        overlays.add(NextLevelMenu.id);
        hasTimerStarted = false;
      }

      if (morale < 5) {
        // chances of riot
      }

      _checkPower();

      if (elapsedSecs % 10 == 0) {
        if (math.Random().nextDouble() < 0.8) {
          overlays.add(EventMenu.id);
          hasTimerStarted = false;
        }
      }
    }, repeat: true);

    camera.viewport.add(BannerComponent(
        position: Vector2(size.x * 0.075, size.y * 0.25),
        size: Vector2.all(45),
        borderSize: 1,
        priority: 0,
        anchor: Anchor.center));
    camera.viewport.add(buildComponent);
    camera.viewport.add(BannerComponent(
        position: Vector2(size.x * 0.075, size.y * 0.40),
        size: Vector2.all(45),
        borderSize: 1,
        priority: 0,
        anchor: Anchor.center));
    camera.viewport.add(ResearchComponent());
    camera.viewport.add(BannerComponent(
        position: Vector2(size.x * 0.075, size.y * 0.55),
        size: Vector2.all(45),
        borderSize: 1,
        priority: 0,
        anchor: Anchor.center));
    camera.viewport.add(PoliciesComponent());
    camera.viewport.add(BannerComponent(
        position: Vector2(size.x * 0.075, size.y * 0.70),
        size: Vector2.all(45),
        borderSize: 1,
        priority: 0,
        anchor: Anchor.center));
    camera.viewport.add(NonGreenComponent());
    camera.viewport.add(pauseComponent);
    camera.viewport.add(Hud());
    camera.viewport.add(BannerComponent(
        position: Vector2(size.x * 0.9, size.y * 0.25),
        size: Vector2.all(45),
        borderSize: 1,
        priority: 0,
        anchor: Anchor.center));
    camera.viewport.add(StatsComponent());
  }

  void _checkPower() {
    if (energy == 0) {
      // stop the factories
      powerShortage = true;
      camera.viewport.add(noPower);
      for (final builtItem in builtItems) {
        paramDelta -= builtItem.paramDelta;
      }
    }

    if (powerShortage && energy > 1e-6) {
      powerShortage = false;
      camera.viewport.remove(noPower);
      for (final builtItem in builtItems) {
        paramDelta += builtItem.paramDelta;
      }
    }
  }

  void _bonusCalculation() {
    bonus = ParamDelta.zero();
    bonus += _bonusWind();
    bonus += _bonusSolar();
  }

  ParamDelta _bonusWind() {
    var bonus = ParamDelta.zero();
    for (final builtItem in builtItems) {
      bonus += builtItem.bonusWind() * windSpeed;
    }
    return bonus;
  }

  ParamDelta _bonusSolar() {
    return ParamDelta.zero();
  }

  void _updateDataPoints() {
    dataPoints.putIfAbsent("health", () => []);
    dataPoints.putIfAbsent("energy", () => []);
    dataPoints.putIfAbsent("carbon", () => []);
    dataPoints.putIfAbsent("resources", () => []);
    dataPoints.putIfAbsent("capital", () => []);
    dataPoints.putIfAbsent("morale", () => []);

    if (dataPoints["health"]!.length >= 10) {
      dataPoints["health"]!.removeAt(0);
      dataPoints["energy"]!.removeAt(0);
      dataPoints["carbon"]!.removeAt(0);
      dataPoints["resources"]!.removeAt(0);
      dataPoints["capital"]!.removeAt(0);
      dataPoints["morale"]!.removeAt(0);
    }
    dataPoints["health"]!
        .add(FlSpot(elapsedSecs.toDouble(), health.toDouble()));
    dataPoints["energy"]!
        .add(FlSpot(elapsedSecs.toDouble(), energy.toDouble()));
    dataPoints["carbon"]!
        .add(FlSpot(elapsedSecs.toDouble(), carbonEmission.toDouble()));
    dataPoints["resources"]!
        .add(FlSpot(elapsedSecs.toDouble(), resources.toDouble()));
    dataPoints["capital"]!
        .add(FlSpot(elapsedSecs.toDouble(), capital.toDouble()));
    dataPoints["morale"]!
        .add(FlSpot(elapsedSecs.toDouble(), morale.toDouble()));
  }

  void pause() {
    pauseComponent.interact();
  }

  void resume() {
    pauseComponent.interact();
  }

  Future<void> _initializeMap() async {
    const xOffset = 1;
    const yOffset = 3;
    final tileSize = mapComponent.tileMap.destTileSize;

    final size = Vector2(tileSize.x / math.sqrt(3), tileSize.y / 2);
    final origin = Vector2(size.x * math.sqrt(3) / 2, size.y);
    final Layout layout = Layout(layout_pointy, size, origin);

    final generatedMap = _mapGenerator.generateMapWithGid();
    for (var i = 0; i < generatedMap.length; i++) {
      for (var j = 0; j < generatedMap[0].length; j++) {
        mapComponent.tileMap.setTileData(
            layerId: 0,
            x: j + yOffset,
            y: i + xOffset,
            gid: generatedMap[i][j]);
      }
    }

    final treeLocationsinOffset =
        _mapGenerator.generateTreeLocations(generatedMap, 10);
    for (var i = 0; i < treeLocationsinOffset.length; i++) {
      final hexAxial = oddrToAxial(Vector2(treeLocationsinOffset[i].x + xOffset,
          treeLocationsinOffset[i].y + yOffset));
      final location = hexToPixel(layout, hexAxial);
      await populateTrees(
          tree: TreeStructure(
              position: Vector2(location.x, location.y),
              priority: 1,
              anchor: Anchor.center)
            ..current = BuildingState.done
            ..timeLeft = 0,
          isPreBuilt: true);
    }

    final buildingLocationsinOffset = _mapGenerator.generateBuildingLocations(
        generatedMap, 10,
        game: this, xOffset: xOffset, yOffset: yOffset);

    for (var i = 0; i < buildingLocationsinOffset.length; i++) {
      final hexAxial = oddrToAxial(Vector2(
          buildingLocationsinOffset[i].x + xOffset,
          buildingLocationsinOffset[i].y + yOffset));
      final location = hexToPixel(layout, hexAxial);
      String buildingName = "house";
      if (i > 4) buildingName = "fossil";
      if (i > 6) buildingName = "waste_incineration";
      if (i > 8) buildingName = "plastic";
      final structure = Structure.factory(buildingName, location);
      addBuiltItem(
          item: structure
            ..priority = 100
            ..current = BuildingState.done
            ..timeLeft = 0,
          isPreBuilt: true);
    }
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

  void nextLevel() async {
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

    paramDelta = ParamDelta.zero();

    world.removeAll(builtItems);
    world.removeAll(trees);
    builtItems = [];
    trees = [];

    await _initializeMap();
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
    capitalSprite = Sprite(await Flame.images.load("capital.png"));
    carbonEmissionSprite = Sprite(await Flame.images.load("carbonControl.png"));
    energySprite = Sprite(await Flame.images.load("energy.png"));
    resourcesSprite = Sprite(await Flame.images.load("resources.png"));
    moraleSprite = Sprite(await Flame.images.load("morale.png"));

    noPower = SpriteComponent(
        position: Vector2(size.x * 0.9, size.y * 0.4),
        anchor: Anchor.center,
        sprite: Sprite(await Flame.images.load("no_power.png")));

    buildComponent = BuildComponent();
    pauseComponent = PausePlayComponent(
        position: Vector2(size.x * 0.075, size.y * 0.9),
        anchor: Anchor.center,
        scale: Vector2.all(1.5));
    Vector2 tileSize = mapComponent.tileMap.destTileSize;
    evFactory = await getSpriteAnimation("ev_factory.png", 4, 0.15, tileSize);
    windmill = await getSpriteAnimation("windmill.png", 4, 0.15, tileSize);
    recyclingFactory =
        await getSpriteAnimation("recycling_factory.png", 4, 0.15, tileSize);
    greenHydrogen =
        await getSpriteAnimation("green_hydrogen.png", 4, 0.15, tileSize);

    publicTransport = Sprite(await Flame.images.load("public_transport.png"));
    carbonTax = Sprite(await Flame.images.load("carbon_tax.png"));
    afforestation = Sprite(await Flame.images.load("grass_13.png"));
    globalTreaty = Sprite(await Flame.images.load("global_treaty.png"));

    carbonTechnology = getObjectSprite(908, 90, 30, 56);
    smartGrid = getObjectSprite(532, 0, 68, 98);
    biodegradable = getObjectSprite(601, 100, 56, 62);
    nanoTechnology = getObjectSprite(712, 433, 50, 50);

    fossilFuel = await getSpriteAnimation("fossil.png", 4, 0.15, tileSize);
    deforestation = await getSpriteAnimation("chemical.png", 4, 0.15, tileSize);
    plastic = await getSpriteAnimation("plastic.png", 4, 0.15, tileSize);
    wasteIncineration =
        await getSpriteAnimation("waste.png", 4, 0.15, tileSize);

    tree = await getSpriteAnimation("tree_animation.png", 4, 0.15, tileSize);
    house = await getSpriteAnimation("house.png", 4, 0.15, tileSize);
    underConstruction =
        await getSpriteAnimation("underconstruction.png", 1, 0.15, tileSize);

    earthquake = Sprite(await Flame.images.load("earthquake.png"));
    forrestFire = Sprite(await Flame.images.load("forrest_fire.png"));

    technologySpecialization = getObjectSprite(904, 437, 34, 41);
    policySpecialization = getObjectSprite(382, 319, 76, 76);
    researchSpecialization = getObjectSprite(594, 384, 58, 108);
  }

  void _scrollingBackground() {
    final backgroundTile = BackgroundTile(
      position: Vector2(0, 0),
    );
    add(backgroundTile);
  }

  Future<SpriteAnimation> getSpriteAnimation(
      String name, int amount, double stepTime, Vector2 textureSize) async {
    SpriteAnimationData data = SpriteAnimationData.sequenced(
      amount: amount,
      stepTime: stepTime,
      textureSize: textureSize,
    );

    final sheet = await Flame.images.load(name);

    return SpriteAnimation.fromFrameData(
      sheet,
      data,
    );
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

  Sprite getSpriteFromSheet(String sheetname,
      {double x = 0, double y = 0, double width = 120, double height = 140}) {
    return Sprite(
      Flame.images.fromCache(sheetname),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }

  Sprite getObjectSprite(double x, double y, double width, double height) {
    return Sprite(
      Flame.images.fromCache('hexagonObjects_sheet.png'),
      srcPosition: Vector2(x, y),
      srcSize: Vector2(width, height),
    );
  }
}
