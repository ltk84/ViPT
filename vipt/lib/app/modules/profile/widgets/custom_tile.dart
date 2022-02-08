import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:path/path.dart' as p;

class CustomTile extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final Function() onPressed;
  final int level;
  const CustomTile(
      {Key? key,
      required this.asset,
      required this.title,
      this.description = '',
      required this.onPressed,
      this.level = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double assetWidthFactor = _getAssetWidthFactor(level);
    double assetHeightFactor = _getAssetHeightFactor(level);
    double gapWidthFactor = _getGapWidthFactor(level);
    double textFieldWidthFactor = _getTextFieldWidthFactor(level);

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // ASSET
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * assetWidthFactor,
                      maxHeight: constraints.maxWidth * assetHeightFactor,
                    ),
                    child: _buildAsset(asset),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * gapWidthFactor,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * textFieldWidthFactor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headline4,
                        ),

                        // DESCRIPTION
                        if (description != '')
                          Text(
                            description,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: AppColor.textColor
                                          .withOpacity(AppColor.subTextOpacity),
                                    ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right_rounded,
              ),
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

  double _getAssetWidthFactor(int level) {
    switch (level) {
      case 0:
        return 0.3;
      case 1:
        return 0.25;
      case 2:
        return 0.2;
      default:
        return 0.3;
    }
  }

  double _getGapWidthFactor(int level) {
    switch (level) {
      case 0:
        return 0.04;
      case 1:
        return 0.04;
      case 2:
        return 0.04;
      default:
        return 0.04;
    }
  }

  double _getTextFieldWidthFactor(int level) {
    switch (level) {
      case 0:
        return 0.56;
      case 1:
        return 0.61;
      case 2:
        return 0.66;
      default:
        return 0.56;
    }
  }

  double _getAssetHeightFactor(int level) {
    switch (level) {
      case 0:
        return 0.4;
      case 1:
        return 0.25;
      case 2:
        return 0.2;
      default:
        return 0.4;
    }
  }
}
