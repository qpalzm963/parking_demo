// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingLot _$ParkingLotFromJson(Map<String, dynamic> json) => ParkingLot(
  carParkId: json['CarParkID'] as String,
  carParkName: CarParkName.fromJson(
    json['CarParkName'] as Map<String, dynamic>,
  ),
  totalSpaces: (json['TotalSpaces'] as num).toInt(),
  availableSpaces: (json['AvailableSpaces'] as num).toInt(),
  latitude: (json['Latitude'] as num?)?.toDouble(),
  longitude: (json['Longitude'] as num?)?.toDouble(),
  address: json['Address'] as String?,
);

Map<String, dynamic> _$ParkingLotToJson(ParkingLot instance) =>
    <String, dynamic>{
      'CarParkID': instance.carParkId,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'CarParkName': instance.carParkName,
      'TotalSpaces': instance.totalSpaces,
      'AvailableSpaces': instance.availableSpaces,
      'Address': instance.address,
    };

CarParkName _$CarParkNameFromJson(Map<String, dynamic> json) =>
    CarParkName(zhTw: json['Zh_tw'] as String);

Map<String, dynamic> _$CarParkNameToJson(CarParkName instance) =>
    <String, dynamic>{'Zh_tw': instance.zhTw};
