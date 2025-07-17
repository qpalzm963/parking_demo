import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parking_taichung/models/curb_parking_spot.dart';
import 'package:parking_taichung/providers/parking_lot_provider.dart';

final taichungCurbSpotProvider = FutureProvider<List<CurbParkingSpot>>((
  ref,
) async {
  final service = ref.watch(tdxServiceProvider);
  final data = await service.fetchTaichungCurbSpots();
  return data.map((e) => CurbParkingSpot.fromJson(e)).toList();
});
