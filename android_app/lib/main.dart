import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_translations.dart';
import 'features/splash/views/splash_view.dart';
import 'features/auth/views/login_view.dart';
import 'features/auth/views/signup_view.dart';
import 'features/auth/views/otp_view.dart';
import 'features/home/views/home_view.dart';
import 'features/trains/views/train_results_view.dart';
import 'features/ntes/views/coach_position_view.dart';
import 'features/ntes/views/spot_train_view.dart';
import 'features/pnr/views/pnr_status_view.dart';
import 'features/uts/views/uts_booking_view.dart';
import 'features/uts/views/platform_ticket_view.dart';
import 'features/tickets/views/digital_ticket_view.dart';
import 'features/wallet/views/wallet_view.dart';
import 'features/madad/views/rail_madad_view.dart';
import 'features/madad/views/track_complaint_view.dart';
import 'features/station/views/station_amenities_view.dart';
import 'features/profile/views/profile_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTranslations.init();
  runApp(const RailOneApp());
}

class RailOneApp extends StatelessWidget {
  const RailOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RailOne',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/signup', page: () => const SignUpView()),
        GetPage(name: '/verify-otp', page: () => const OtpView()),
        GetPage(name: '/home', page: () => const HomeView()),
        GetPage(name: '/train-results', page: () => const TrainResultsView()),
        GetPage(name: '/coach-position', page: () => const CoachPositionView()),
        GetPage(name: '/spot-train', page: () => const SpotYourTrainView()),
        GetPage(name: '/pnr-status', page: () => const PnrStatusView()),
        GetPage(name: '/uts-booking', page: () => const UtsBookingView()),
        GetPage(name: '/platform-ticket', page: () => const PlatformTicketView()),
        GetPage(name: '/ticket-view', page: () => const DigitalTicketView()),
        GetPage(name: '/r-wallet', page: () => const WalletView()),
        GetPage(name: '/rail-madad', page: () => const RailMadadView()),
        GetPage(name: '/track-complaint', page: () => const TrackComplaintView()),
        GetPage(name: '/station-amenities', page: () => const StationAmenitiesView()),
        GetPage(name: '/profile', page: () => const ProfileView()),
      ],
    );
  }
}

