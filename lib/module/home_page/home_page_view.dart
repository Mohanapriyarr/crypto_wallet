import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:inocyx/data/resources/color_resouce.dart';
import 'package:inocyx/data/resources/constant_resource.dart';
import 'package:inocyx/module/home_page/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<HomePageController>(HomePageController());
  //  controller.loginUsingMetamask(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: APP_MAIN_YELLOW,
          child: Text(
            'Connect Wallet',
            style: h2_light(context),
          ),
        ),
      ),
    );
  }
}
