import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/pages/competitor_pricing.dart';
import 'package:coresight/ui/pages/home/main_page.dart';
import 'package:coresight/ui/pages/leave_create_page.dart';
import 'package:coresight/ui/pages/leave_detail_page.dart';
import 'package:coresight/ui/pages/leave_list_page.dart';
import 'package:coresight/ui/pages/login_page.dart';
import 'package:coresight/ui/pages/off_day_create_page.dart';
import 'package:coresight/ui/pages/off_day_detail_page.dart';
import 'package:coresight/ui/pages/off_day_list_page.dart';
import 'package:coresight/ui/pages/onboarding_page.dart';
import 'package:coresight/ui/pages/permit_create_page.dart';
import 'package:coresight/ui/pages/permit_detail_page.dart';
import 'package:coresight/ui/pages/permit_list_page.dart';
import 'package:coresight/ui/pages/presence_photo_page.dart';
import 'package:coresight/ui/pages/presence_preview_page.dart';
import 'package:coresight/ui/pages/presence_report_detail_page.dart';
import 'package:coresight/ui/pages/presence_report_list_page.dart';
import 'package:coresight/ui/pages/presence_zonation_page.dart';
import 'package:coresight/ui/pages/pricing_page.dart';
import 'package:coresight/ui/pages/promotion_page.dart';
import 'package:coresight/ui/pages/rental_display_page.dart';
import 'package:coresight/ui/pages/sales_order_preview_page.dart';
import 'package:coresight/ui/pages/sales_order_product_page.dart';
import 'package:coresight/ui/pages/sales_order_submit_page.dart';
import 'package:coresight/ui/pages/share_of_shelf_page.dart';
import 'package:coresight/ui/pages/sick_leave_create_page.dart';
import 'package:coresight/ui/pages/sick_leave_detail_page.dart';
import 'package:coresight/ui/pages/sick_leave_list_page.dart';
import 'package:coresight/ui/pages/splash_page.dart';
import 'package:coresight/ui/pages/stock_page.dart';
import 'package:coresight/ui/pages/store_visit_photo_page.dart';
import 'package:coresight/ui/pages/store_visit_preview_page.dart';
import 'package:coresight/ui/pages/store_visit_store_page.dart';
import 'package:coresight/ui/pages/store_visit_zonation_page.dart';
import 'package:coresight/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalToast.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: lightBackgroundColor),
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/signin': (context) => const LoginPage(),
        '/home': (context) => const MainPage(),
        '/pricing': (context) => const PricingPage(),
        '/stock': (context) => const StockPage(),
        '/sos': (context) => const ShareOfShelfPage(),
        '/rental-display': (context) => const RentalDisplayPage(),
        '/competitor-pricing': (context) => const CompetitorPricing(),
        '/promotion': (context) => const PromotionPage(),
        '/so-product': (context) => const SalesOrderProductPage(),
        '/so-preview': (context) => const SalesOrderPreviewPage(),
        '/so-submit': (context) => const SalesOrderSubmitPage(),
        '/sick-leave': (context) => const SickLeaveListPage(),
        '/sick-leave-create': (context) => const SickLeaveCreatePage(),
        '/sick-leave-detail': (context) => const SickLeaveDetailPage(),
        '/permit': (context) => const PermitListPage(),
        '/permit-create': (context) => const PermitCreatePage(),
        '/permit-detail': (context) => const PermitDetailPage(),
        '/offday': (context) => const OffDayListPage(),
        '/offday-create': (context) => const OffDayCreatePage(),
        '/offday-detail': (context) => const OffDayDetailPage(),
        '/leave': (context) => const LeaveListPage(),
        '/leave-create': (context) => const LeaveCreatePage(),
        '/leave-detail': (context) => const LeaveDetailPage(),
        '/presence-report': (context) => const PresenceReportListPage(),
        '/presence-report-detail': (context) =>
            const PresenceReportDetailPage(),
        '/store-visit': (context) => const StoreVisitStorePage(),
        '/store-visit-zonation': (context) => const StoreVisitZonationPage(),
        '/store-visit-photo': (context) => const StoreVisitPhotoPage(),
        '/store-visit-preview': (context) => const StoreVisitPreviewPage(),
        '/presence-zonation': (context) => const PresenceZonationPage(),
        '/presence-photo': (context) => const PresencePhotoPage(),
        '/presence-preview': (context) => const PresencePreviewPage(),
      },
    );
  }
}
