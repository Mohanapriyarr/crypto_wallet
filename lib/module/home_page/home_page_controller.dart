import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class HomePageController extends GetxController {
  final uri = ''.obs;

  SessionStatus? sessionStatus;

  WalletConnect? connector;

  @override
  Future<void> onInit() async {
    final client = Web3Client(
        'https://mainnet.infura.io/v3/0f46e78a9f7e4328a5433620a4752b8f',
        Client());

    await getLatestBlockNumber(client);
    await getBalance(client);
    // connector = WalletConnect(
    //     bridge: 'https://bridge.walletconnect.org',
    //     clientMeta: const PeerMeta(
    //         name: 'My App',
    //         description: 'An app for converting pictures to NFT',
    //         url: 'https://walletconnect.org',
    //         icons: [
    //           'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
    //         ]));
    super.onInit();

    //  await loginUsingMetamask(Get.context!);
  }

  Future<void> getLatestBlockNumber(Web3Client client) async {
    try {
      // Call Ethereum client to get the latest block number
      final blockNumber = await client.getBlockNumber();
      print('Latest Block Number: $blockNumber');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getBalance(Web3Client client) async {
    final address = EthereumAddress.fromHex(
        '0x42Aa30a622046567d5de639e2aC6b593160c8887'); // Replace with actual address
    final balance = await client.getBalance(address);
    print('Balance: ${balance.getValueInUnit(EtherUnit.ether)} ETH');
  }

  loginUsingMetamask(BuildContext context) async {
    connector = WalletConnect(
        bridge: 'https://bridge.walletconnect.org',
        clientMeta: const PeerMeta(
            name: 'My App',
            description: 'An app for converting pictures to NFT',
            url: 'https://walletconnect.org',
            icons: [
              'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
            ]));
    if (!connector!.connected) {
      try {
        var session = await connector?.createSession(onDisplayUri: (url) async {
          uri.value = url;
          debugPrint('URI value: $url');

          // Attempt to launch the URL and handle potential errors here as well
          try {
            await launchUrlString(url, mode: LaunchMode.externalApplication);
          } on PlatformException catch (launchError) {
            debugPrint("Error launching URL: ${launchError.message}");
            if (launchError.code == 'ACTIVITY_NOT_FOUND') {
              debugPrint("No compatible wallet app found.");
            }
          }
        });

        debugPrint('Session Account: ${session?.accounts[0]}');
        debugPrint('Session ChainId: ${session?.chainId}');
        debugPrint('Session: $session');

        sessionStatus = session;
      } on PlatformException catch (e) {
        // More explicit handling for PlatformException
        if (e.code == 'ACTIVITY_NOT_FOUND') {
          debugPrint("PlatformException: No compatible wallet app found.");
        } else {
          debugPrint("PlatformException: ${e.message}");
        }
      } catch (exp) {
        // Catching any other exceptions
        debugPrint("An unexpected error occurred: $exp");
      }
    }
  }
}

//0f46e78a9f7e4328a5433620a4752b8f
//https://mainnet.infura.io/v3/0f46e78a9f7e4328a5433620a4752b8f

class Unit {
  static const ether = 'ether'; // Represents Ether
  static const gwei = 'gwei'; // Represents Gwei
  static const wei = 'wei'; // Represents Wei
}
