import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/profile/widgets/custom_sliver_delegate.dart';
import 'package:vipt/app/routes/pages.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                  backgroundColor: Theme.of(context).primaryColor,
                  action: [
                    IconButton(
                      color: Theme.of(context).backgroundColor,
                      icon: const Hero(
                        tag: 'actionButtonAppBar',
                        child: Icon(
                          Icons.settings,
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.library);
                      },
                    ),
                  ],
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                  expandedHeight: 200),
            ),
            SliverFillRemaining(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: const Text(''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
