import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../controllers/home_controller.dart';
import '../../search/views/station_search_modal.dart';
import '../../splash/views/language_modal.dart';
import '../../tickets/views/digital_ticket_view.dart';

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
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        elevation: 2,
        title: Row(
          children: [
            Image.asset(
              AppAssets.appIconWhite,
              width: 34,
              height: 34,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.train_rounded, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'RailOne',
                  style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                Text(
                  'CRIS Indian Railways',
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language_rounded, color: Colors.white),
            tooltip: 'Change Language',
            onPressed: () => Get.bottomSheet(const LanguageSelectModal()),
          ),
          IconButton(
            icon: Badge(
              label: const Text('2', style: TextStyle(color: Colors.white, fontSize: 10)),
              backgroundColor: const Color(0xFFDC2626),
              child: const Icon(Icons.notifications_outlined, color: Colors.white),
            ),
            onPressed: () {
              Get.snackbar(
                'Notifications',
                'Train 12951 running on time. Platform 3 assigned at NDLS.',
                backgroundColor: Colors.white,
                colorText: AppColors.textPrimary,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.all(12),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => Get.toNamed('/profile'),
              borderRadius: BorderRadius.circular(20),
              child: CircleAvatar(
                radius: 17,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Image.asset(
                  AppAssets.myAccountCard,
                  width: 22,
                  height: 22,
                  errorBuilder: (ctx, err, stack) => const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
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
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF0D47A1),
          unselectedItemColor: const Color(0xFF64748B),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          backgroundColor: Colors.white,
          elevation: 12,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.myBookingCard,
                width: 22,
                height: 22,
                color: homeCtrl.currentTabIndex.value == 1 ? const Color(0xFF0D47A1) : const Color(0xFF64748B),
                errorBuilder: (ctx, err, stack) => const Icon(Icons.confirmation_num_outlined),
              ),
              label: 'My Bookings',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.spotTrain,
                width: 22,
                height: 22,
                errorBuilder: (ctx, err, stack) => const Icon(Icons.search_rounded),
              ),
              label: 'Enquiries',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.complaintIcon,
                width: 22,
                height: 22,
                errorBuilder: (ctx, err, stack) => const Icon(Icons.support_agent_rounded),
              ),
              label: 'Rail Madad',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // HOME TAB
  // -------------------------------------------------------------
  Widget _buildHomeTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWalletCard(),
          _buildTicketingModeHeroSelector(),
          Obx(() => homeCtrl.ticketingMode.value == 0
              ? _buildReservedTicketingForm()
              : _buildUnreservedTicketingForm()),
          _buildCarousel(),
          _buildInActionSection(),
          _buildEnquiriesGrid(),
          _buildMoreAndFreightSection(),
        ],
      ),
    );
  }

  // R-WALLET STRIP
  Widget _buildWalletCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D47A1).withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            AppAssets.rWalletIcon,
            width: 44,
            height: 44,
            errorBuilder: (ctx, err, stack) => const Icon(Icons.account_balance_wallet, color: Color(0xFFF59E0B), size: 38),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'R-Wallet',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '3% Cashback on UTS',
                        style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Obx(() => Text(
                      '₹ ${homeCtrl.walletBalance.value.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/r-wallet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              foregroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text(
              'Add Money',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // PRIMARY DUAL-TICKETING SELECTOR (Reserved vs Unreserved / UTS)
  Widget _buildTicketingModeHeroSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book Tickets',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // 1. Reserved Ticket Card
              Expanded(
                child: Obx(() {
                  final isSelected = homeCtrl.ticketingMode.value == 0;
                  return InkWell(
                    onTap: () => homeCtrl.setTicketingMode(0),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF0D47A1) : const Color(0xFFE2E8F0),
                          width: isSelected ? 2.0 : 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isSelected ? 0.08 : 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.cardReserve,
                            height: 60,
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, stack) => const Icon(Icons.confirmation_number_rounded, color: Color(0xFF0D47A1), size: 48),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Reserved Ticket',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'IRCTC Berths & Trains',
                            style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 12),
              // 2. Unreserved (UTS) Ticket Card
              Expanded(
                child: Obx(() {
                  final isSelected = homeCtrl.ticketingMode.value == 1;
                  return InkWell(
                    onTap: () => homeCtrl.setTicketingMode(1),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF0D47A1) : const Color(0xFFE2E8F0),
                          width: isSelected ? 2.0 : 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(isSelected ? 0.08 : 0.03),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            AppAssets.cardUnreserve,
                            height: 60,
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, stack) => const Icon(Icons.train_rounded, color: Color(0xFF10B981), size: 48),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Unreserved',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: const Text(
                                  'UTS',
                                  style: TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Suburban & General',
                            style: TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // RESERVED TICKETING FORM
  Widget _buildReservedTicketingForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Origin Station
          InkWell(
            onTap: () async {
              final station = await Get.to(() => const StationSearchModal(title: 'Origin Station'));
              if (station != null) homeCtrl.fromStation.value = station;
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                const Icon(Icons.trip_origin_rounded, color: Color(0xFF0D47A1), size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('From', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      Obx(() => Text(
                            '${homeCtrl.fromStation.value.name} (${homeCtrl.fromStation.value.code})',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
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
              const Divider(color: Color(0xFFE2E8F0), height: 26),
              Positioned(
                right: 18,
                child: InkWell(
                  onTap: homeCtrl.swapStations,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D47A1),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      AppAssets.swapIcon,
                      width: 16,
                      height: 16,
                      color: Colors.white,
                      errorBuilder: (ctx, err, stack) => const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Destination Station
          InkWell(
            onTap: () async {
              final station = await Get.to(() => const StationSearchModal(title: 'Destination Station'));
              if (station != null) homeCtrl.toStation.value = station;
            },
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: [
                const Icon(Icons.location_on_rounded, color: Color(0xFFDC2626), size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      Obx(() => Text(
                            '${homeCtrl.toStation.value.name} (${homeCtrl.toStation.value.code})',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFE2E8F0), height: 24),
          // Journey Date & Quota Row
          Row(
            children: [
              // Date Picker
              Expanded(
                flex: 3,
                child: InkWell(
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
                      const Icon(Icons.calendar_month_rounded, color: Color(0xFF0D47A1), size: 20),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Date', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                          Obx(() => Text(
                                DateFormat('dd MMM, yyyy').format(homeCtrl.journeyDate.value),
                                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
              const SizedBox(width: 12),
              // Quota Selector
              Expanded(
                flex: 2,
                child: Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: homeCtrl.selectedQuota.value,
                      isDense: true,
                      icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF0D47A1)),
                      items: ['General', 'Tatkal', 'Ladies', 'Sr. Citizen'].map((q) {
                        return DropdownMenuItem(
                          value: q,
                          child: Text(q, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) homeCtrl.selectedQuota.value = val;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search Trains CTA
          ElevatedButton.icon(
            onPressed: () => Get.toNamed('/train-results'),
            icon: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
            label: const Text(
              'Search Trains',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // UNRESERVED (UTS) TICKETING FORM
  Widget _buildUnreservedTicketingForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Paperless vs Paper Segmented Bar
          Obx(() {
            final isPaperless = homeCtrl.utsBookingType.value == 'paperless';
            return Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => homeCtrl.utsBookingType.value = 'paperless',
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: isPaperless ? const Color(0xFF0D47A1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Book & Travel (Paperless)',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: isPaperless ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => homeCtrl.utsBookingType.value = 'paper',
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: !isPaperless ? const Color(0xFF0D47A1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Book & Print (Paper)',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: !isPaperless ? Colors.white : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          // UTS Geofence Alert Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.utsAlertIcon,
                  width: 22,
                  height: 22,
                  errorBuilder: (ctx, err, stack) => const Icon(Icons.check_circle_outline, color: Color(0xFF10B981), size: 20),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Inside Geofence Zone (350m from NDLS). Paperless ticket available.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF065F46), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Quick Service Type Selection
          Row(
            children: [
              _buildUtsServiceTypeChip('Journey Ticket', 'journey', Icons.train_outlined),
              const SizedBox(width: 8),
              _buildUtsServiceTypeChip('Platform Ticket', 'platform', Icons.pin_drop_outlined),
              const SizedBox(width: 8),
              _buildUtsServiceTypeChip('Season Ticket', 'season', Icons.date_range_outlined),
            ],
          ),
          const SizedBox(height: 14),
          // Origin & Destination Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('From (Depart)', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                    const SizedBox(height: 2),
                    Obx(() => Text(
                          '${homeCtrl.fromStation.value.name} (${homeCtrl.fromStation.value.code})',
                          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, color: Color(0xFF0D47A1), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final station = await Get.to(() => const StationSearchModal(title: 'Select Destination'));
                    if (station != null) homeCtrl.toStation.value = station;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To (Destination)', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      const SizedBox(height: 2),
                      Obx(() => Text(
                            '${homeCtrl.toStation.value.name} (${homeCtrl.toStation.value.code})',
                            style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFE2E8F0), height: 22),
          // Train Type & Passengers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Train Type
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Train Type', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  Obx(
                    () => DropdownButton<String>(
                      value: homeCtrl.utsTrainType.value,
                      isDense: true,
                      underline: const SizedBox(),
                      items: ['Ordinary', 'Mail/Express', 'Superfast'].map((t) {
                        return DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) homeCtrl.utsTrainType.value = val;
                      },
                    ),
                  ),
                ],
              ),
              // Passengers
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Adults', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (homeCtrl.utsAdultCount.value > 1) homeCtrl.utsAdultCount.value--;
                        },
                        child: const Icon(Icons.remove_circle_outline, color: Color(0xFF0D47A1), size: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Obx(() => Text(
                              '${homeCtrl.utsAdultCount.value}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          if (homeCtrl.utsAdultCount.value < 4) homeCtrl.utsAdultCount.value++;
                        },
                        child: const Icon(Icons.add_circle_outline, color: Color(0xFF0D47A1), size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Fare & R-Wallet Discount Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                          'Fare: ₹ ${homeCtrl.calculateUtsFare().toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 11, decoration: TextDecoration.lineThrough, color: Color(0xFF92400E)),
                        )),
                    Obx(() => Text(
                          'R-Wallet Price: ₹ ${homeCtrl.calculateUtsDiscountedFare().toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF78350F)),
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Save 3%',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Book UTS Ticket CTA
          ElevatedButton(
            onPressed: () {
              Get.to(() => const DigitalTicketView(
                    ticketNumber: 'UTS-98234-A7',
                    trainName: 'NDLS - BCT SUBURBAN EXPRESS',
                    sourceStation: 'NEW DELHI (NDLS)',
                    destStation: 'MUMBAI CENTRAL (BCT)',
                    pnr: 'UTS-LOCAL-88',
                    fare: '₹ 29.10',
                  ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text(
              'Book UTS Ticket (Instant Paperless)',
              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtsServiceTypeChip(String label, String value, IconData icon) {
    return Expanded(
      child: Obx(() {
        final isSelected = homeCtrl.utsServiceType.value == value;
        return InkWell(
          onTap: () {
            homeCtrl.utsServiceType.value = value;
            if (value == 'platform') {
              Get.toNamed('/platform-ticket');
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0D47A1) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: isSelected ? Colors.white : const Color(0xFF64748B)),
                const SizedBox(width: 4),
                Text(
                  label.split(' ')[0],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // BANNER CAROUSEL
  Widget _buildCarousel() {
    return Column(
      children: [
        const SizedBox(height: 12),
        CarouselSlider(
          options: CarouselOptions(
            height: 135,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enlargeCenterPage: true,
            viewportFraction: 0.92,
            onPageChanged: (index, reason) {
              setState(() => _carouselIndex = index);
            },
          ),
          items: _carouselImages.map((imgPath) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imgPath,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (ctx, err, stack) => Container(
                  color: const Color(0xFF0D47A1),
                  alignment: Alignment.center,
                  child: const Text('Indian Railways', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        DotsIndicator(
          dotsCount: _carouselImages.length,
          position: _carouselIndex,
          decorator: DotsDecorator(
            size: const Size.square(6.0),
            activeSize: const Size(16.0, 6.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
            activeColor: const Color(0xFF0D47A1),
            color: const Color(0xFFCBD5E1),
          ),
        ),
      ],
    );
  }

  // IN ACTION (RECENT ACTIVITY)
  Widget _buildInActionSection() {
    final actions = [
      {'title': 'PNR Status', 'asset': AppAssets.inactionPnr, 'route': '/pnr-status'},
      {'title': 'Seat Availability', 'asset': AppAssets.inactionSeat, 'route': '/train-results'},
      {'title': 'Food on Train', 'asset': AppAssets.inactionFood, 'route': '/train-results'},
      {'title': 'Cancellation', 'asset': AppAssets.inactionCancellation, 'route': '/pnr-status'},
      {'title': 'Retiring Room', 'asset': AppAssets.inactionRetiring, 'route': '/station-amenities'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'In Action',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: actions.map((item) {
                return InkWell(
                  onTap: () => Get.toNamed(item['route']!),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 78,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          item['asset']!,
                          width: 40,
                          height: 40,
                          errorBuilder: (ctx, err, stack) => const Icon(Icons.apps_rounded, color: Color(0xFF0D47A1)),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['title']!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ENQUIRIES & NTES LIVE TRACKING
  Widget _buildEnquiriesGrid() {
    final enquiries = [
      {'title': 'Spot Train', 'subtitle': 'Live NTES GPS', 'asset': AppAssets.spotTrain, 'route': '/spot-train'},
      {'title': 'Live Station', 'subtitle': 'Next 2-4 Hours', 'asset': AppAssets.liveStation, 'route': '/spot-train'},
      {'title': 'Coach Position', 'subtitle': 'Platform Layout', 'asset': AppAssets.coachPosition, 'route': '/coach-position'},
      {'title': 'Train Schedule', 'subtitle': 'Route & Timings', 'asset': AppAssets.trainSchedule, 'route': '/spot-train'},
      {'title': 'Platform Ticket', 'subtitle': 'Quick Passes', 'asset': AppAssets.cardPlatform, 'route': '/platform-ticket'},
      {'title': 'Station Facilities', 'subtitle': 'Water, Lifts, ATM', 'asset': AppAssets.amenityWater, 'route': '/station-amenities'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enquiries & Live Tracking',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: enquiries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = enquiries[index];
              return InkWell(
                onTap: () => Get.toNamed(item['route']!),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['asset']!,
                        height: 38,
                        fit: BoxFit.contain,
                        errorBuilder: (ctx, err, stack) => const Icon(Icons.train, color: Color(0xFF0D47A1), size: 32),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['subtitle']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 8.5, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // MORE SERVICES & PARCEL / FREIGHT
  Widget _buildMoreAndFreightSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More Services & Freight',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildMiniServiceItem('E-Catering', AppAssets.moreOrderFood, () {
                      Get.snackbar('IRCTC e-Catering', 'Opening partner food delivery for Train 12951');
                    }),
                    _buildMiniServiceItem('Fare Calc', AppAssets.moreFareCalculator, () => Get.toNamed('/train-results')),
                    _buildMiniServiceItem('Chart Vacancy', AppAssets.moreChartVacancy, () => Get.toNamed('/pnr-status')),
                    _buildMiniServiceItem('Parcel Booking', AppAssets.parcelRate, () {
                      Get.snackbar('Parcel Services', 'Indian Railways Parcel Management System');
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniServiceItem(String title, String asset, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              Image.asset(
                asset,
                height: 32,
                errorBuilder: (ctx, err, stack) => const Icon(Icons.miscellaneous_services_rounded, color: Color(0xFF0D47A1), size: 28),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF334155)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // MY BOOKINGS TAB (Reserved & Unreserved / UTS Split)
  // -------------------------------------------------------------
  Widget _buildBookingsTab() {
    return Column(
      children: [
        // Dual Tab Header (Reserved vs UTS)
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            children: [
              Obx(() {
                final isReserved = homeCtrl.bookingsSubTabIndex.value == 0;
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => homeCtrl.bookingsSubTabIndex.value = 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isReserved ? const Color(0xFF0D47A1) : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Reserved Tickets',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isReserved ? FontWeight.bold : FontWeight.w500,
                              color: isReserved ? const Color(0xFF0D47A1) : const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => homeCtrl.bookingsSubTabIndex.value = 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: !isReserved ? const Color(0xFF0D47A1) : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Unreserved (UTS)',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: !isReserved ? FontWeight.bold : FontWeight.w500,
                                  color: !isReserved ? const Color(0xFF0D47A1) : const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'ACTIVE',
                                  style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        // Booking Content Body
        Expanded(
          child: Obx(() {
            return homeCtrl.bookingsSubTabIndex.value == 0
                ? _buildReservedBookingsList()
                : _buildUtsBookingsList();
          }),
        ),
      ],
    );
  }

  Widget _buildReservedBookingsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildBookingTicketCard(
          pnr: '2847593021',
          trainNo: '12951',
          trainName: 'TEJAS RAJDHANI EXPRESS',
          fromCode: 'NDLS',
          toCode: 'BCT',
          depTime: '16:55',
          arrTime: '08:35',
          travelDate: '12 Nov 2026',
          coach: 'B4',
          berth: '36 (MB)',
          bookingClass: '3A',
          status: 'CONFIRMED',
          statusColor: const Color(0xFF10B981),
        ),
        const SizedBox(height: 12),
        _buildBookingTicketCard(
          pnr: '6482019374',
          trainNo: '22436',
          trainName: 'VANDE BHARAT EXPRESS',
          fromCode: 'NDLS',
          toCode: 'BSB',
          depTime: '06:00',
          arrTime: '14:00',
          travelDate: '28 Nov 2026',
          coach: 'C2',
          berth: '18 (WS)',
          bookingClass: 'CC',
          status: 'RAC 12',
          statusColor: const Color(0xFFF59E0B),
        ),
      ],
    );
  }

  Widget _buildUtsBookingsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Active UTS Journey Ticket
        InkWell(
          onTap: () {
            Get.to(() => const DigitalTicketView(
                  ticketNumber: 'UTS-98234-A7',
                  trainName: 'SUBURBAN FAST LOCAL',
                  sourceStation: 'NEW DELHI (NDLS)',
                  destStation: 'GHAZIABAD (GZB)',
                  pnr: 'UTS-LOCAL-88',
                  fare: '₹ 20.00',
                ));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppAssets.utsIcon,
                          width: 28,
                          height: 28,
                          errorBuilder: (ctx, err, stack) => const Icon(Icons.qr_code_2_rounded, color: Color(0xFF10B981)),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'JOURNEY TICKET (PAPERLESS)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFFA7F3D0)),
                      ),
                      child: const Text(
                        'VALID FOR 2h 45m',
                        style: TextStyle(color: Color(0xFF059669), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('NEW DELHI (NDLS)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF64748B), size: 18),
                    Text('GHAZIABAD (GZB)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 Adult • Second Class (2S)', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                    Text('Fare Paid: ₹ 19.40', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0D47A1))),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Show QR Code to TTE',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingTicketCard({
    required String pnr,
    required String trainNo,
    required String trainName,
    required String fromCode,
    required String toCode,
    required String depTime,
    required String arrTime,
    required String travelDate,
    required String coach,
    required String berth,
    required String bookingClass,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('PNR: $pnr', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0D47A1))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('$trainNo - $trainName', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const Divider(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(depTime, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(fromCode, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
              const Icon(Icons.arrow_forward_rounded, color: Color(0xFF94A3B8), size: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(arrTime, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(toCode, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$travelDate • Class $bookingClass', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              Text('Coach: $coach, Berth: $berth', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // OTHER GLOBAL TABS (Enquiries, Madad, More)
  // -------------------------------------------------------------
  Widget _buildEnquiriesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEnquiryLargeTile('Spot Your Train', 'Live NTES GPS location & delays', AppAssets.spotTrain, '/spot-train'),
        const SizedBox(height: 12),
        _buildEnquiryLargeTile('PNR Enquiry', 'Live chart preparation & confirmation status', AppAssets.inactionPnr, '/pnr-status'),
        const SizedBox(height: 12),
        _buildEnquiryLargeTile('Coach Position', 'Locate your coach along the platform', AppAssets.coachPosition, '/coach-position'),
        const SizedBox(height: 12),
        _buildEnquiryLargeTile('Station Facilities', 'Escalators, drinking water, waiting rooms', AppAssets.amenityWater, '/station-amenities'),
      ],
    );
  }

  Widget _buildEnquiryLargeTile(String title, String subtitle, String asset, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Image.asset(
              asset,
              width: 48,
              height: 48,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.search, size: 40, color: Color(0xFF0D47A1)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  Widget _buildMadadTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Image.asset(
                AppAssets.complaintIcon,
                width: 48,
                height: 48,
                errorBuilder: (ctx, err, stack) => const Icon(Icons.support_agent, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rail Madad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 3),
                    Text('24x7 Grievance Redressal for Indian Railways', style: TextStyle(color: Colors.white70, fontSize: 11.5)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildEnquiryLargeTile('File a Complaint', 'Lodge grievances regarding train, coach or station', AppAssets.complaintIcon, '/rail-madad'),
        const SizedBox(height: 12),
        _buildEnquiryLargeTile('Track Grievance Status', 'Check real-time resolution timeline', AppAssets.helpWebClaim, '/track-complaint'),
      ],
    );
  }

  Widget _buildMoreTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEnquiryLargeTile('R-Wallet & Cashback', 'Check balance, history & recharge', AppAssets.rWalletIcon, '/r-wallet'),
        const SizedBox(height: 12),
        _buildEnquiryLargeTile('Profile & Security', 'Manage Aadhaar, Biometrics, mPIN', AppAssets.myAccountCard, '/profile'),
        const SizedBox(height: 12),
        _buildEnquiryLargeTile('Platform Tickets', 'Book digital platform entry pass', AppAssets.cardPlatform, '/platform-ticket'),
      ],
    );
  }
}
