import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parking_taichung/providers/parking_lot_provider.dart';
import '../models/onstreet_parking_spot.dart';

final parkingSegmentAvailabilityProvider =
    FutureProvider.family<List<ParkingSegmentAvailability>, String>((
      ref,
      city,
    ) async {
      final service = ref.watch(tdxServiceProvider);
      return service.fetchParkingSegmentAvailability(city: city);
    });
final nearbyOnStreetSpotProvider =
    FutureProvider.family<List<OnStreetParkingSpot>, NearbySpotQuery>((
      ref,
      params,
    ) async {
      final service = ref.read(tdxServiceProvider);
      final data = await service.fetchNearbyOnStreetSpots(
        latitude: params.latitude,
        longitude: params.longitude,
        distance: params.distance,
        top: params.top,
      );
      return data.map((e) => OnStreetParkingSpot.fromJson(e)).toList();
    });

final offStreetNearbyCarParkProvider =
    FutureProvider.family<List<OffStreetCarPark>, NearbySpotQuery>((
      ref,
      query,
    ) async {
      final tdxService = ref.watch(tdxServiceProvider);
      return tdxService.fetchNearbyOffStreetCarParks(
        latitude: query.latitude,
        longitude: query.longitude,
        distance: query.distance,
        top: query.top,
      );
    });

class NearbySpotQuery {
  final double latitude;
  final double longitude;
  final int distance;
  final int top;
  final int queryId; // 唯一 id

  NearbySpotQuery({
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.top,
    required this.queryId,
  });

  // 請一定要把 queryId 加到 ==/hashCode 裡
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NearbySpotQuery &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          distance == other.distance &&
          top == other.top &&
          queryId == other.queryId;

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      distance.hashCode ^
      top.hashCode ^
      queryId.hashCode;
}
