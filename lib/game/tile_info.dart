import 'dart:ui';

class TileInfo {
  TileInfo({
    required this.center,
    required this.row,
    required this.col,
  });

  final Offset center;
  final int row;
  final int col;

  @override
  String toString() {
      return "TileInfo: center: $center, row: $row, col: $col";
    }
}
