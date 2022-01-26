import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final _controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: double.maxFinite,
      width: double.maxFinite,
      alignment: Alignment.center,
      child: Image.asset(
        GIFAssetString.logoAnimation,
        height: 80,
      ),
    );
  }
}
