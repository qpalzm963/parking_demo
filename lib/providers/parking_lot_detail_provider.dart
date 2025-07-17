// providers/parking_lot_detail_provider.dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parking_taichung/models/parking_lot.dart';
import 'package:parking_taichung/providers/parking_lot_provider.dart';

final parkingLotDetailProvider = FutureProvider.family<ParkingLot?, String>((
  ref,
  carParkId,
) async {
  final service = ref.watch(tdxServiceProvider);
  return await service.fetchParkingLotDetail(carParkId);
});
