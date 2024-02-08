enum TileType {
  grassLand(id: 22),
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
