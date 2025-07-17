import 'package:json_annotation/json_annotation.dart';

part 'onstreet_parking_spot.g.dart';

@JsonSerializable()
class OnStreetParkingSpot {
  @JsonKey(name: "ParkingSegmentID")
  final String parkingSegmentId;

  @JsonKey(name: "ParkingSpotID")
  final String parkingSpotId;

  @JsonKey(name: "Position")
  final Position position;

  @JsonKey(name: "SpaceType")
  final int spaceType;

  @JsonKey(name: "HasChargingPoint")
  final int hasChargingPoint;

  const OnStreetParkingSpot({
    required this.parkingSegmentId,
    required this.parkingSpotId,
    required this.position,
    required this.spaceType,
    required this.hasChargingPoint,
  });

  factory OnStreetParkingSpot.fromJson(Map<String, dynamic> json) =>
      _$OnStreetParkingSpotFromJson(json);

  Map<String, dynamic> toJson() => _$OnStreetParkingSpotToJson(this);
}

@JsonSerializable()
class Position {
  @JsonKey(name: "PositionLat")
  final double lat;

  @JsonKey(name: "PositionLon")
  final double lon;

  const Position({required this.lat, required this.lon});

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}

class OffStreetCarPark {
  final String carParkId;
  final String carParkNameZhTw;
  final String? description;
  final int? carParkType;
  final int? parkingGuideType;
  final List<int>? parkingTypes;
  final List<int>? parkingSiteTypes;
  final List<int>? chargeTypes;
  final String? telephone;
  final String? emergencyPhone;
  final double latitude;
  final double longitude;
  final String? address;
  final String? fareDescription;
  final String? webUrl;
  final String? landMark;

  OffStreetCarPark({
    required this.carParkId,
    required this.carParkNameZhTw,
    this.description,
    this.carParkType,
    this.parkingGuideType,
    this.parkingTypes,
    this.parkingSiteTypes,
    this.chargeTypes,
    this.telephone,
    this.emergencyPhone,
    required this.latitude,
    required this.longitude,
    this.address,
    this.fareDescription,
    this.webUrl,
    this.landMark,
  });

  factory OffStreetCarPark.fromJson(Map<String, dynamic> json) {
    final position = json['CarParkPosition'] ?? {};
    return OffStreetCarPark(
      carParkId: json['CarParkID'] ?? '',
      carParkNameZhTw: (json['CarParkName']?['Zh_tw'] ?? '').toString(),
      description: json['Description'],
      carParkType: json['CarParkType'],
      parkingGuideType: json['ParkingGuideType'],
      parkingTypes:
          (json['ParkingTypes'] as List?)?.map((e) => e as int).toList(),
      parkingSiteTypes:
          (json['ParkingSiteTypes'] as List?)?.map((e) => e as int).toList(),
      chargeTypes:
          (json['ChargeTypes'] as List?)?.map((e) => e as int).toList(),
      telephone: json['Telephone'],
      emergencyPhone: json['EmergencyPhone'],
      latitude: (position['PositionLat'] as num?)?.toDouble() ?? 0,
      longitude: (position['PositionLon'] as num?)?.toDouble() ?? 0,
      address: json['Address'],
      fareDescription: json['FareDescription'],
      webUrl: json['WebURL'],
      landMark: json['LandMark'],
    );
  }
}

class ParkingSegmentAvailability {
  final String parkingSegmentId;
  final String parkingSegmentNameZhTw;
  final int totalSpaces;
  final int availableSpaces;
  final List<SegmentAvailability> availabilities;
  final int serviceStatus;
  final int fullStatus;
  final int chargeStatus;
  final String dataCollectTime;

  ParkingSegmentAvailability({
    required this.parkingSegmentId,
    required this.parkingSegmentNameZhTw,
    required this.totalSpaces,
    required this.availableSpaces,
    required this.availabilities,
    required this.serviceStatus,
    required this.fullStatus,
    required this.chargeStatus,
    required this.dataCollectTime,
  });

  factory ParkingSegmentAvailability.fromJson(Map<String, dynamic> json) {
    return ParkingSegmentAvailability(
      parkingSegmentId: json['ParkingSegmentID'] ?? '',
      parkingSegmentNameZhTw: json['ParkingSegmentName']?['Zh_tw'] ?? '',
      totalSpaces: json['TotalSpaces'] ?? 0,
      availableSpaces: json['AvailableSpaces'] ?? 0,
      availabilities:
          (json['Availabilities'] as List? ?? [])
              .map((e) => SegmentAvailability.fromJson(e))
              .toList(),
      serviceStatus: json['ServiceStatus'] ?? 0,
      fullStatus: json['FullStatus'] ?? 0,
      chargeStatus: json['ChargeStatus'] ?? 0,
      dataCollectTime: json['DataCollectTime'] ?? '',
    );
  }
}

class SegmentAvailability {
  final int spaceType;
  final int numberOfSpaces;
  final int availableSpaces;
  final double occupancy;

  SegmentAvailability({
    required this.spaceType,
    required this.numberOfSpaces,
    required this.availableSpaces,
    required this.occupancy,
  });

  factory SegmentAvailability.fromJson(Map<String, dynamic> json) {
    return SegmentAvailability(
      spaceType: json['SpaceType'] ?? 0,
      numberOfSpaces: json['NumberOfSpaces'] ?? 0,
      availableSpaces: json['AvailableSpaces'] ?? 0,
      occupancy: double.tryParse(json['Occupancy'].toString()) ?? 0.0,
    );
  }
}
