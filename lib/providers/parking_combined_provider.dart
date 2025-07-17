import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parking_taichung/models/curb_parking_spot.dart';
import 'package:parking_taichung/models/parking_display_item.dart';
import 'parking_lot_provider.dart';
import 'curb_spot_provider.dart';

final parkingCombinedProvider = FutureProvider<List<ParkingDisplayItem>>((
  ref,
) async {
  final lots = await ref.watch(taichungParkingProvider.future);
  final spots = await ref.watch(taichungCurbSpotProvider.future);

  // 停車場
  final lotItems = lots.map(
    (e) => ParkingDisplayItem(
      type: ParkingType.lot,
      id: e.carParkId,
      name: e.carParkName.zhTw,
      subTitle: e.address,
      total: e.totalSpaces,
      available: e.availableSpaces,
      raw: e,
    ),
  );

  // 路邊停車格，這邊 group by parkingSegmentId
  final spotMap = <String, List<CurbParkingSpot>>{};
  for (final s in spots) {
    spotMap.putIfAbsent(s.parkingSegmentId, () => []).add(s);
  }
  final curbItems = spotMap.entries.map((entry) {
    final available = entry.value.where((s) => s.spotStatus == 1).length;
    return ParkingDisplayItem(
      type: ParkingType.curb,
      id: entry.key,
      name: "路邊段 ${entry.key}",
      subTitle: null,
      total: entry.value.length,
      available: available,
      raw: entry.value,
    );
  });

  return [...lotItems, ...curbItems];
});
