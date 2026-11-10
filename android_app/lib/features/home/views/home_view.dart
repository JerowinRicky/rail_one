import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../controllers/home_controller.dart';
import '../../search/views/station_search_modal.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeCtrl = Get.put(HomeController());
  int _carouselIndex = 0;

  final List<String> _carouselImages = [
    AppAssets.carouselHome,
    AppAssets.chenabBridge,
    AppAssets.noneyBridge,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              AppAssets.appIconWhite,
              width: 32,
              height: 32,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.train_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 10),
            const Text('RailOne'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'Change Language',
            onPressed: () => _showLanguageModal(context),
          ),
          IconButton(
            icon: const Badge(
              label: Text('2'),
              child: Icon(Icons.notifications_outlined),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Get.toNamed('/profile'),
          ),
        ],
      ),
      body: Obx(() {
        if (homeCtrl.currentTabIndex.value == 0) {
          return _buildHomeTab();
        } else if (homeCtrl.currentTabIndex.value == 1) {
          return _buildBookingsTab();
        } else if (homeCtrl.currentTabIndex.value == 2) {
          return _buildEnquiriesTab();
        } else if (homeCtrl.currentTabIndex.value == 3) {
          return _buildMadadTab();
        } else {
          return _buildMoreTab();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homeCtrl.currentTabIndex.value,
          onTap: homeCtrl.updateTabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined), label: 'My Bookings'),
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Enquiries'),
            BottomNavigationBarItem(icon: Icon(Icons.support_agent_rounded), label: 'Rail Madad'),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'More'),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWalletCard(),
          _buildSearchCard(),
          _buildCarousel(),
          _buildInActionSection(),
          _buildServicesGrid(),
          _buildParcelFreightSection(),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: AppColors.walletGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            AppAssets.walletGif,
            width: 42,
            height: 42,
            errorBuilder: (ctx, err, stack) => const Icon(Icons.account_balance_wallet, color: AppColors.accentGold, size: 36),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'rWallet'.tr,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '3% Cashback',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                      '₹ ${homeCtrl.walletBalance.value.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/r-wallet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGold,
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            child: Text('addMoneyNow'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Origin Station
            InkWell(
              onTap: () async {
                final station = await Get.to(() => const StationSearchModal(title: 'originStation'));
                if (station != null) homeCtrl.fromStation.value = station;
              },
              child: Row(
                children: [
                  const Icon(Icons.train_outlined, color: AppColors.primaryBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('from'.tr, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        Obx(() => Text(
                              '${homeCtrl.fromStation.value.name} (${homeCtrl.fromStation.value.code})',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Station Swap Divider
            Stack(
              alignment: Alignment.center,
              children: [
                const Divider(color: AppColors.cardBorder, height: 28),
                Positioned(
                  right: 20,
                  child: InkWell(
                    onTap: homeCtrl.swapStations,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            // Destination Station
            InkWell(
              onTap: () async {
                final station = await Get.to(() => const StationSearchModal(title: 'whereTo'));
                if (station != null) homeCtrl.toStation.value = station;
              },
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.dangerRed),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('to'.tr, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        Obx(() => Text(
                              '${homeCtrl.toStation.value.name} (${homeCtrl.toStation.value.code})',
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.cardBorder, height: 24),
            // Journey Date Selector
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: homeCtrl.journeyDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 120)),
                );
                if (picked != null) homeCtrl.journeyDate.value = picked;
              },
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, color: AppColors.secondarySky, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('when'.tr, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        Obx(() => Text(
                              DateFormat('EEE, dd MMM yyyy').format(homeCtrl.journeyDate.value),
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // Search Trains Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search_rounded),
                label: Text('search'.tr),
                onPressed: () => Get.toNamed(
                  '/train-results',
                  arguments: {
                    'from': homeCtrl.fromStation.value.code,
                    'to': homeCtrl.toStation.value.code,
                    'date': DateFormat('yyyy-MM-dd').format(homeCtrl.journeyDate.value),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        const SizedBox(height: 10),
        CarouselSlider.builder(
          itemCount: _carouselImages.length,
          options: CarouselOptions(
            height: 130,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) => setState(() => _carouselIndex = index),
          ),
          itemBuilder: (context, index, realIdx) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                _carouselImages[index],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (ctx, err, stack) => Container(
                  color: AppColors.primaryBlueLight,
                  child: const Center(
                    child: Icon(Icons.train_rounded, color: Colors.white, size: 48),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        DotsIndicator(
          dotsCount: _carouselImages.length,
          position: _carouselIndex,
          decorator: DotsDecorator(
            activeColor: AppColors.primaryBlue,
            color: AppColors.cardBorder,
            size: const Size.square(6),
            activeSize: const Size(18, 6),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    );
  }

  Widget _buildInActionSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'inAction'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildInActionCard('PnrStatus'.tr, AppAssets.inactionPnr, () => Get.toNamed('/pnr-status')),
              _buildInActionCard('foodOnTrain'.tr, AppAssets.orderFoodSvg, () => Get.toNamed('/catering')),
              _buildInActionCard('cancellation'.tr, AppAssets.inactionCancellation, () => Get.toNamed('/bulletins')),
              _buildInActionCard('seatAvailability'.tr, AppAssets.inactionSeat, () => Get.toNamed('/train-results')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInActionCard(String title, String asset, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: [
              Image.asset(
                asset,
                height: 32,
                width: 32,
                errorBuilder: (ctx, err, stack) => const Icon(Icons.info_outline, size: 28, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {'title': 'Reserved Ticket', 'icon': AppAssets.cardReserve, 'route': '/train-results'},
      {'title': 'UTS Ticket', 'icon': AppAssets.cardUnreserve, 'route': '/uts-booking'},
      {'title': 'Platform Ticket', 'icon': AppAssets.cardPlatform, 'route': '/platform-ticket'},
      {'title': 'Spot Your Train', 'icon': AppAssets.spotTrain, 'route': '/spot-train'},
      {'title': 'Coach Position', 'icon': AppAssets.coachPosition, 'route': '/coach-position'},
      {'title': 'Live Station', 'icon': AppAssets.liveStation, 'route': '/live-station'},
      {'title': 'Train Schedule', 'icon': AppAssets.trainSchedule, 'route': '/schedule'},
      {'title': 'Retiring Room', 'icon': AppAssets.retiringRoom, 'route': '/station-amenities'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'moreServices'.tr,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              TextButton(
                onPressed: homeCtrl.toggleServicesExpanded,
                child: Text(
                  homeCtrl.isServicesExpanded.value ? 'viewLess'.tr : 'viewAll'.tr,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                ),
              ),
            ],
          ),
          Obx(() {
            final itemsToShow = homeCtrl.isServicesExpanded.value ? services : services.take(4).toList();
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemsToShow.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.85,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (ctx, idx) {
                final item = itemsToShow[idx];
                return GestureDetector(
                  onTap: () => Get.toNamed(item['route']!),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item['icon']!,
                          height: 36,
                          width: 36,
                          errorBuilder: (ctx, err, stack) => const Icon(Icons.directions_train, size: 30, color: AppColors.primaryBlue),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['title']!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildParcelFreightSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'parcelServices'.tr,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildSecondaryActionCard('Track Consignment', Icons.local_shipping_outlined, () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSecondaryActionCard('Rate Calculator', Icons.calculate_outlined, () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryActionCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('selectLanguage'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('English'),
                trailing: Get.locale?.languageCode == 'en' ? const Icon(Icons.check, color: AppColors.primaryBlue) : null,
                onTap: () {
                  Get.updateLocale(const Locale('en', 'US'));
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('हिंदी (Hindi)'),
                trailing: Get.locale?.languageCode == 'hi' ? const Icon(Icons.check, color: AppColors.primaryBlue) : null,
                onTap: () {
                  Get.updateLocale(const Locale('hi', 'IN'));
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Upcoming Journeys', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('12952 - MUMBAI RAJDHANI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.successGreenLight, borderRadius: BorderRadius.circular(4)),
                      child: const Text('CNF', style: TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('New Delhi (NDLS) -> Mumbai Central (BCT)', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const Text('15-Nov-2026 • Coach B2, Berth 45 (MB)', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: () => Get.toNamed('/ticket-view'), child: const Text('View Ticket')),
                    TextButton(onPressed: () => Get.toNamed('/coach-position'), child: const Text('Coach Position')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnquiriesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Railway Enquiries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildEnquiryTile('PNR Status', Icons.confirmation_number_outlined, () => Get.toNamed('/pnr-status')),
        _buildEnquiryTile('Spot Your Train', Icons.gps_fixed_rounded, () => Get.toNamed('/spot-train')),
        _buildEnquiryTile('Coach Position', Icons.format_list_numbered_rounded, () => Get.toNamed('/coach-position')),
        _buildEnquiryTile('Train Schedule', Icons.schedule_rounded, () => Get.toNamed('/schedule')),
        _buildEnquiryTile('Station Amenities', Icons.storefront_outlined, () => Get.toNamed('/station-amenities')),
      ],
    );
  }

  Widget _buildEnquiryTile(String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildMadadTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Rail Madad - Grievance Redressal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            icon: const Icon(Icons.add_comment_rounded),
            label: const Text('Lodge New Complaint'),
            onPressed: () => Get.toNamed('/rail-madad'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            icon: const Icon(Icons.track_changes_rounded),
            label: const Text('Track Existing Complaint'),
            onPressed: () => Get.toNamed('/track-complaint'),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('More Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildEnquiryTile('Profile & Security', Icons.person_outline, () => Get.toNamed('/profile')),
        _buildEnquiryTile('R-Wallet Balance & Recharge', Icons.account_balance_wallet_outlined, () => Get.toNamed('/r-wallet')),
        _buildEnquiryTile('UTS Ticket Booking', Icons.train_outlined, () => Get.toNamed('/uts-booking')),
        _buildEnquiryTile('Platform Ticket Booking', Icons.airplane_ticket_outlined, () => Get.toNamed('/platform-ticket')),
      ],
    );
  }
}

