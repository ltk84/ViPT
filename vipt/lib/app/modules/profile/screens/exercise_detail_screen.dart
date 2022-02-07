import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as p;
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/values.dart';

class ExerciseDetail extends StatelessWidget {
  const ExerciseDetail({Key? key}) : super(key: key);

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
                  'Tên bài tập',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Danh mục A, Danh mục B, Danh mục C',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth,
                    maxHeight: constraints.maxHeight * 0.3,
                  ),
                  child: _buildAsset(PNGAssetString.fitness_1),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 24,
                  bottom: 8,
                ),
                child: Text(
                  'Gợi ý',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eros lorem, luctus at congue in, hendrerit sit amet lorem. Suspendisse dapibus orci et elementum luctus.',
                  style: Theme.of(context).textTheme.bodyText1),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  'Hít thở',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                  style: Theme.of(context).textTheme.bodyText1),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  'Nhóm cơ tập trung',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.45,
                    ),
                    child: _buildAsset(PNGAssetString.workout_1),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.1,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.45,
                    ),
                    child: _buildAsset(PNGAssetString.workout_2),
                  ),
                ],
              ),
              SizedBox(
                height: constraints.maxHeight * 0.03,
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAsset(String asset) {
    if (p.extension(asset) == '.svg') {
      return SvgPicture.asset(asset);
    } else {
      return Image.asset(asset);
    }
  }
}
