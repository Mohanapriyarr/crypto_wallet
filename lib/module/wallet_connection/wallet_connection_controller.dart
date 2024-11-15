import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletConnectionController extends GetxController {
  WalletConnect? connector;

  final uri = ''.obs;

  SessionStatus? sessionStatus;

  @override
  void onInit() {
    connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
            name: 'My App',
            description: 'An app for converting pictures to NFT',
            url: 'https://walletconnect.org',
            icons: [
              'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ]));
    super.onInit();
  }

  loginUsingMetamask(BuildContext context) async {
    if (!connector!.connected) {
      try {
        var session = await connector?.createSession(onDisplayUri: (url) async {
          uri.value = url;
          print('uri value $url');

          await launchUrlString(url, mode: LaunchMode.externalApplication);
        });
        print(session?.accounts[0]);
        print(session?.chainId);
        print('session $session');

        sessionStatus = session;
      } catch (exp) {
        print(exp);
      }
    }
  }
}
