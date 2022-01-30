import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (_) => Container(),
              );

            case 1:
              return CupertinoTabView(
                builder: (_) => Container(),
              );
            default:
              return Container();
          }
        },
        tabBar: CupertinoTabBar(
          currentIndex: _controller.tabIndex.value,
          onTap: _controller.onChangeTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: 'Page 1'),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm_outlined), label: 'Page 2'),
          ],
        ));
  }
}
