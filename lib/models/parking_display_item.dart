enum ParkingType { lot, curb }

class ParkingDisplayItem {
  final ParkingType type;
  final String id;
  final String name;
  final String? subTitle;
  final int total;
  final int available;
  final dynamic raw;

  ParkingDisplayItem({
    required this.type,
    required this.id,
    required this.name,
    this.subTitle,
    required this.total,
    required this.available,
    this.raw,
  });
}
