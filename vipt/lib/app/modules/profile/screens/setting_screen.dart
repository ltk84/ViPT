import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Cài đặt'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            ListTile(
              onTap: () {},
              leading: Icon(Icons.info, color: AppColor.textColor),
              title: Text(
                'Thay đổi thông tin ban đầu',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.checklist_rounded, color: AppColor.textColor),
              title: Text(
                'Thay đổi mục tiêu cân nặng',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            ListTile(
              onTap: () {},
              leading:
                  Icon(Icons.auto_awesome_rounded, color: AppColor.textColor),
              title: Text(
                'Đề xuất lộ trình mới',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {},
              leading:
                  Icon(Icons.exit_to_app_rounded, color: AppColor.textColor),
              title: Text(
                'Đăng xuất',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
