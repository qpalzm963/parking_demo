import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/parking_combined_provider.dart';
import '../models/parking_display_item.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combined = ref.watch(parkingCombinedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("台中即時停車總覽")),
      body: combined.when(
        data:
            (items) => ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, i) {
                final item = items[i];
                return ListTile(
                  leading: Icon(
                    item.type == ParkingType.lot
                        ? Icons.local_parking
                        : Icons.directions_car,
                  ),
                  title: Text(item.name),
                  subtitle: item.subTitle != null ? Text(item.subTitle!) : null,
                  trailing: Text("剩餘: ${item.available}/${item.total}"),
                  onTap: () {
                    // 展開詳細頁，根據 item.type 判斷
                  },
                );
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('錯誤: $e')),
      ),
    );
  }
}
