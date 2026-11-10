import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/station_model.dart';
import '../../../data/services/mock_api_service.dart';

class StationSearchModal extends StatefulWidget {
  final String title;
  const StationSearchModal({super.key, this.title = 'searchStation'});

  @override
  State<StationSearchModal> createState() => _StationSearchModalState();
}

class _StationSearchModalState extends State<StationSearchModal> {
  final searchController = TextEditingController();
  List<Station> results = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _performSearch('');
  }

  void _performSearch(String query) async {
    setState(() => isLoading = true);
    final list = await MockApiService.searchStations(query);
    setState(() {
      results = list;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.title.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              controller: searchController,
              autofocus: true,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search station by name or code (e.g. NDLS)...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                        onPressed: () {
                          searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
              ),
            ),
          ),
          if (isLoading)
            const LinearProgressIndicator(
              color: AppColors.primaryBlue,
              backgroundColor: AppColors.background,
            ),
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Text(
                      'No stations found'.tr,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (ctx, idx) => const Divider(height: 1, color: AppColors.divider),
                    itemBuilder: (ctx, idx) {
                      final station = results[idx];
                      return ListTile(
                        tileColor: AppColors.surface,
                        leading: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            station.code,
                            style: const TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        title: Text(
                          station.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        subtitle: Text(
                          '${station.hindiName} • ${station.zone} (${station.state})',
                          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
                        onTap: () => Get.back(result: station),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

