import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';

class StationAmenitiesView extends StatefulWidget {
  const StationAmenitiesView({super.key});

  @override
  State<StationAmenitiesView> createState() => _StationAmenitiesViewState();
}

class _StationAmenitiesViewState extends State<StationAmenitiesView> {
  final stationController = TextEditingController(text: 'NDLS');

  final List<Map<String, dynamic>> amenities = [
    {'title': 'RO Drinking Water', 'loc': 'Platforms 1 to 16 (Near Coaches 4 & 12)', 'icon': AppAssets.amenityWater},
    {'title': 'Executive Lounge & Waiting Hall', 'loc': 'Platform 1 & 16 (First Floor)', 'icon': AppAssets.amenityToilet},
    {'title': 'Clean Restrooms & Washrooms', 'loc': 'All Platforms near FOB stairs', 'icon': AppAssets.amenityToilet},
    {'title': 'IRCTC Food Plaza & Jan Aahar', 'loc': 'Platform 1 & Concourse', 'icon': AppAssets.orderFoodSvg},
    {'title': 'Escalators & Elevators', 'loc': 'Connecting FOB 1, 2, and 3', 'icon': AppAssets.amenityEscalator},
    {'title': 'Wheelchair Assistance', 'loc': 'Platform 1 Deputy SS Office', 'icon': AppAssets.amenityWheelchair},
    {'title': 'ATMs & Banking', 'loc': 'Ajmeri Gate & Paharganj Entries', 'icon': AppAssets.amenityAtm},
    {'title': 'Retiring Rooms & Dormitory', 'loc': 'Platform 1 First Floor (Book online)', 'icon': AppAssets.retiringRoom},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Know Your Station Amenities'),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: stationController,
                    decoration: const InputDecoration(labelText: 'Station Code (e.g. NDLS)'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: () => setState(() {}), child: const Text('Search')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: amenities.length,
              itemBuilder: (ctx, idx) {
                final item = amenities[idx];
                return Card(
                  child: ListTile(
                    leading: Image.asset(
                      item['icon']!,
                      width: 38,
                      height: 38,
                      errorBuilder: (ctx, err, stack) => const Icon(Icons.storefront, color: AppColors.primaryBlue),
                    ),
                    title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: Text(item['loc']!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

