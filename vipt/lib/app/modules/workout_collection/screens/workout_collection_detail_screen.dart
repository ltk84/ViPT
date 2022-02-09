import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';

class WorkoutCollectionDetailScreen extends StatelessWidget {
  const WorkoutCollectionDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: Container(
        padding: AppDecoration.screenPadding.copyWith(top: 8, bottom: 0),
        child: LayoutBuilder(builder: (context, constraints) {
          return ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Tên bộ luyện tập',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Mô tả mô tả mô tả mô tả mô tả mô tả',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.access_time_filled_rounded,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('10 phút'),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    height: 20,
                    child: VerticalDivider(),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(CupertinoIcons.flame_fill),
                  SizedBox(
                    width: 8,
                  ),
                  Text('100 calo'),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
