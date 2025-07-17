import 'package:json_annotation/json_annotation.dart';
part 'curb_parking_spot.g.dart';

@JsonSerializable()
class CurbParkingSpot {
  @JsonKey(name: "ParkingSpotID")
  final String parkingSpotId;

  @JsonKey(name: "ParkingSegmentID")
  final String parkingSegmentId;

  @JsonKey(name: "ServiceStatus")
  final int serviceStatus;

  @JsonKey(name: "SpotStatus")
  final int spotStatus;

  @JsonKey(name: "DeviceStatus")
  final int deviceStatus;

  @JsonKey(name: "ChargeStatus")
  final int chargeStatus;

  @JsonKey(name: "DataCollectTime")
  final String dataCollectTime;

  CurbParkingSpot({
    required this.parkingSpotId,
    required this.parkingSegmentId,
    required this.serviceStatus,
    required this.spotStatus,
    required this.deviceStatus,
    required this.chargeStatus,
    required this.dataCollectTime,
  });

  factory CurbParkingSpot.fromJson(Map<String, dynamic> json) =>
      _$CurbParkingSpotFromJson(json);
  Map<String, dynamic> toJson() => _$CurbParkingSpotToJson(this);
}
