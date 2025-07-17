import 'package:json_annotation/json_annotation.dart';
part 'parking_lot.g.dart';

@JsonSerializable()
class ParkingLot {
  @JsonKey(name: "CarParkID")
  final String carParkId;
  @JsonKey(name: "Latitude")
  final double? latitude;
  @JsonKey(name: "Longitude")
  final double? longitude;
  @JsonKey(name: "CarParkName")
  final CarParkName carParkName;

  @JsonKey(name: "TotalSpaces")
  final int totalSpaces;

  @JsonKey(name: "AvailableSpaces")
  final int availableSpaces;

  @JsonKey(name: "Address")
  final String? address;

  ParkingLot({
    required this.carParkId,
    required this.carParkName,
    required this.totalSpaces,
    required this.availableSpaces,
    required this.latitude,
    required this.longitude,
    this.address,
  });

  factory ParkingLot.fromJson(Map<String, dynamic> json) =>
      _$ParkingLotFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingLotToJson(this);
}

@JsonSerializable()
class CarParkName {
  @JsonKey(name: "Zh_tw")
  final String zhTw;
  CarParkName({required this.zhTw});
  factory CarParkName.fromJson(Map<String, dynamic> json) =>
      _$CarParkNameFromJson(json);
  Map<String, dynamic> toJson() => _$CarParkNameToJson(this);
}
