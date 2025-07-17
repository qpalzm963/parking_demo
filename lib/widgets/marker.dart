import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

enum MarkerType { lot, spot, offStreet }

class MarkerFactory {
  static Marker build({
    required MarkerType type,
    required double latitude,
    required double longitude,
    BuildContext? context,
    // Lot
    String? name,
    int? availableSpaces,
    int? totalSpaces,
    String? address,
    // Spot
    String? spotId,
    bool? hasChargingPoint,
    // OffStreet
    String? fareDescription,
  }) {
    switch (type) {
      case MarkerType.lot:
        return Marker(
          point: LatLng(latitude, longitude),
          width: 45,
          height: 45,
          child: IconButton(
            icon: const Icon(Icons.local_parking, color: Colors.blue, size: 40),
            onPressed:
                context == null
                    ? null
                    : () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (_) => SafeArea(
                              child: ListTile(
                                title: Text(name ?? ''),
                                subtitle: Text(
                                  '剩餘: $availableSpaces/$totalSpaces\n${address ?? ""}',
                                ),
                              ),
                            ),
                      );
                    },
          ),
        );
      case MarkerType.offStreet:
        return Marker(
          point: LatLng(latitude, longitude),
          width: 45,
          height: 45,
          child: IconButton(
            icon: const Icon(
              Icons.local_parking,
              color: Colors.green,
              size: 40,
            ),
            onPressed:
                context == null
                    ? null
                    : () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (_) => SafeArea(
                              child: ListTile(
                                title: Text(name ?? ''),
                                subtitle: Text(
                                  '${address ?? ""}\n${fareDescription ?? ""}',
                                ),
                              ),
                            ),
                      );
                    },
          ),
        );
      case MarkerType.spot:
        return Marker(
          point: LatLng(latitude, longitude),
          width: 36,
          height: 36,
          child: IconButton(
            icon: const Icon(
              Icons.directions_car,
              color: Colors.orange,
              size: 30,
            ),
            onPressed:
                context == null
                    ? null
                    : () {
                      showModalBottomSheet(
                        context: context,
                        builder:
                            (_) => SafeArea(
                              child: ListTile(
                                title: Text('格號: $spotId'),
                                subtitle: Text(
                                  '座標: $latitude, $longitude\n充電樁: ${hasChargingPoint == true ? "有" : "無"}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.navigation),
                                  onPressed: () {
                                    final url =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                                    launchUrl(Uri.parse(url));
                                  },
                                ),
                              ),
                            ),
                      );
                    },
          ),
        );
    }
  }
}
