enum TileType {
  highLand(id: 6),
  grassLand(id: 2),
  water(id: 3);

  const TileType({required this.id});
  final int id;
}

class TileData {
  TileData({
    required this.type,
  });

  final TileType type;
}
