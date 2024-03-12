enum TileType {
  highLand(id: 5),
  grassLand(id: 1),
  water(id: 0);

  const TileType({required this.id});
  final int id;
}

class TileData {
  TileData({
    required this.type,
  });

  final TileType type;
}
