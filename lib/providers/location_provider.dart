import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

// final locationProvider = StreamProvider<LatLng>((ref) async* {
//   await Geolocator.requestPermission();
//   await for (final pos in Geolocator.getPositionStream(
//     locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
//   )) {
//     yield LatLng(pos.latitude, pos.longitude);
//   }
// });

final locationProvider = FutureProvider<LatLng>((ref) async {
  await Geolocator.requestPermission();
  final pos = await Geolocator.getCurrentPosition();
  return LatLng(pos.latitude, pos.longitude);
});
