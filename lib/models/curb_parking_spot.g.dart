// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curb_parking_spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurbParkingSpot _$CurbParkingSpotFromJson(Map<String, dynamic> json) =>
    CurbParkingSpot(
      parkingSpotId: json['ParkingSpotID'] as String,
      parkingSegmentId: json['ParkingSegmentID'] as String,
      serviceStatus: (json['ServiceStatus'] as num).toInt(),
      spotStatus: (json['SpotStatus'] as num).toInt(),
      deviceStatus: (json['DeviceStatus'] as num).toInt(),
      chargeStatus: (json['ChargeStatus'] as num).toInt(),
      dataCollectTime: json['DataCollectTime'] as String,
    );

Map<String, dynamic> _$CurbParkingSpotToJson(CurbParkingSpot instance) =>
    <String, dynamic>{
      'ParkingSpotID': instance.parkingSpotId,
      'ParkingSegmentID': instance.parkingSegmentId,
      'ServiceStatus': instance.serviceStatus,
      'SpotStatus': instance.spotStatus,
      'DeviceStatus': instance.deviceStatus,
      'ChargeStatus': instance.chargeStatus,
      'DataCollectTime': instance.dataCollectTime,
    };
