import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:parking_taichung/widgets/marker.dart';
import 'package:parking_taichung/providers/onstreet_spot_provider.dart';

class ParkingMapScreen extends HookConsumerWidget {
  const ParkingMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastCenter = useState<LatLng>(LatLng(25.047675, 121.517055));
    final segmentAsync = ref.watch(
      parkingSegmentAvailabilityProvider('Taichung'),
    );

    // 停車場、路邊停車格資料
    final currentQuery = useState<NearbySpotQuery>(
      NearbySpotQuery(
        latitude: lastCenter.value.latitude,
        longitude: lastCenter.value.longitude,
        distance: 1000,
        top: 30,
        queryId:
            DateTime.now().millisecondsSinceEpoch, // 若有用 queryId 保證 re-fetch
      ),
    );

    final nearbySpotsAsync = ref.watch(
      nearbyOnStreetSpotProvider(currentQuery.value),
    );

    final offStreetNearbyAsync = ref.watch(
      offStreetNearbyCarParkProvider(currentQuery.value),
    );
    // FlutterMap controller
    final mapController = useMemoized(() => MapController(), const []);
    void onMapMoved(MapCamera pos, bool hasGesture) {
      // if (hasGesture) {
      lastCenter.value = pos.center;
      // }
    }

    // 自動定位 & 只會執行一次
    useEffect(() {
      Future(() async {
        try {
          LocationPermission permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
          }
          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            final position = await Geolocator.getCurrentPosition();
            final userLatLng = LatLng(position.latitude, position.longitude);
            lastCenter.value = userLatLng;
            mapController.move(userLatLng, 15);
          }
        } catch (_) {
          // 沒有權限就保持 defaultCenter
        }
      });
      return null;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('停車場＋路邊停車格地圖'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: "回到我的定位",
            onPressed: () async {
              // 你可以這裡用定位 API 抓用戶位置
              final position = await Geolocator.getCurrentPosition();
              final LatLng myLocation = LatLng(
                position.latitude,
                position.longitude,
              );
              mapController.move(myLocation, 15);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              // initialCenter: lastCenter.value,
              initialZoom: 15,
              onPositionChanged: (pos, hasGesture) => onMapMoved(pos, false),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.parkingapp',
              ),
              // 顯示使用者當前位置
              FutureBuilder<Position>(
                future: Geolocator.getCurrentPosition(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final pos = snapshot.data!;
                    return MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(pos.latitude, pos.longitude),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.my_location,
                            color: Colors.blueAccent,
                            size: 36,
                          ),
                        ),
                      ],
                    );
                  }
                  return const MarkerLayer(markers: []);
                },
              ),
              offStreetNearbyAsync.when(
                data:
                    (list) => MarkerLayer(
                      markers:
                          list
                              .map(
                                (carPark) => MarkerFactory.build(
                                  type: MarkerType.offStreet,
                                  latitude: carPark.latitude,
                                  longitude: carPark.longitude,
                                  context: context,
                                  name: carPark.carParkNameZhTw,
                                  address: carPark.address,
                                  fareDescription: carPark.fareDescription,
                                ),
                              )
                              .toList(),
                    ),
                loading: () => MarkerLayer(markers: []), // 無資料也可給空
                error: (e, _) => MarkerLayer(markers: []), // 出錯時不顯示
              ),
              // 路邊停車格
              nearbySpotsAsync.when(
                data:
                    (list) => MarkerLayer(
                      markers:
                          list
                              .map(
                                (s) => MarkerFactory.build(
                                  type: MarkerType.spot,
                                  latitude: s.position.lat,
                                  longitude: s.position.lon,
                                  context: context,
                                  spotId: s.parkingSpotId,
                                  hasChargingPoint: s.hasChargingPoint == 1,
                                ),
                              )
                              .toList(),
                    ),
                loading: () => MarkerLayer(markers: []), // 無資料也可給空
                error: (e, _) => MarkerLayer(markers: []), // 出錯時不顯示
              ),
            ],
          ),
          if (nearbySpotsAsync.isLoading)
            const Positioned(
              right: 16,
              top: 16,
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("查詢此處附近"),
        icon: const Icon(Icons.search),
        onPressed: () {
          currentQuery.value = NearbySpotQuery(
            latitude: lastCenter.value.latitude,
            longitude: lastCenter.value.longitude,
            distance: 1000,
            top: 30,
            queryId: DateTime.now().millisecondsSinceEpoch, // 可選
          );
          // ref.invalidate(nearbyOnStreetSpotProvider);
        },
      ),
    );
  }
}
