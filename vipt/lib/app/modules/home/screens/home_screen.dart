import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home ne'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await _controller.signOut();
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
