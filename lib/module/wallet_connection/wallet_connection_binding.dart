import 'package:get/instance_manager.dart';
import 'package:inocyx/module/wallet_connection/wallet_connection_controller.dart';

class WalletConnectionBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<WalletConnectionController>(() => WalletConnectionController());
  }

}