import 'package:get/route_manager.dart';
import 'package:inocyx/module/home_page/home_page_binding.dart';
import 'package:inocyx/module/home_page/home_page_view.dart';
import 'package:inocyx/module/wallet_connection/wallet_connection_binding.dart';
import 'package:inocyx/module/wallet_connection/wallet_connection_view.dart';
import 'package:inocyx/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomePageView(),
        binding: HomePageBinding(),
        transition: Transition.leftToRightWithFade),
    GetPage(
        name: Routes.HOME,
        page: () => const WalletConnectionView(),
        binding: WalletConnectionBinding(),
        transition: Transition.leftToRightWithFade)
  ];
}
