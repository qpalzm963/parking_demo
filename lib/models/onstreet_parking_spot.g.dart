// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onstreet_parking_spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnStreetParkingSpot _$OnStreetParkingSpotFromJson(Map<String, dynamic> json) =>
    OnStreetParkingSpot(
      parkingSegmentId: json['ParkingSegmentID'] as String,
      parkingSpotId: json['ParkingSpotID'] as String,
      position: Position.fromJson(json['Position'] as Map<String, dynamic>),
      spaceType: (json['SpaceType'] as num).toInt(),
      hasChargingPoint: (json['HasChargingPoint'] as num).toInt(),
    );

Map<String, dynamic> _$OnStreetParkingSpotToJson(
  OnStreetParkingSpot instance,
) => <String, dynamic>{
  'ParkingSegmentID': instance.parkingSegmentId,
  'ParkingSpotID': instance.parkingSpotId,
  'Position': instance.position,
  'SpaceType': instance.spaceType,
  'HasChargingPoint': instance.hasChargingPoint,
};

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
  lat: (json['PositionLat'] as num).toDouble(),
  lon: (json['PositionLon'] as num).toDouble(),
);

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
  'PositionLat': instance.lat,
  'PositionLon': instance.lon,
};
