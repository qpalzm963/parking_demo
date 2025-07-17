import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/tdx_service.dart';
import '../models/parking_lot.dart';

final tdxServiceProvider = Provider((ref) => TdxService());

final taichungParkingProvider = FutureProvider<List<ParkingLot>>((ref) async {
  final service = ref.watch(tdxServiceProvider);
  final data = await service.fetchTaichungParkingLots();
  return data.map((e) => ParkingLot.fromJson(e)).toList();
});
