import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:path/path.dart' as p;
import 'package:vipt/app/global_widgets/network_image.dart';

class CustomTile extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final Function() onPressed;
  final int type;
  const CustomTile(
      {Key? key,
      required this.asset,
      required this.title,
      this.description = '',
      required this.onPressed,
      this.type = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double assetWidth = _getAssetWidth(type);
    double assetHeight = _getAssetHeight(type);
    double gapWidthFactor = _getGapWidthFactor(type);
    double textFieldWidthFactor = _getTextFieldWidthFactor(type);
    TextStyle? titleStyle = _getTitleStyle(context, type);

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: description != ''
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.center,
                children: [
                  // ASSET
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: assetHeight,
                      width: assetWidth,
                      decoration: BoxDecoration(
                        color: type != 3
                            ? AppColor.textFieldFill
                                .withOpacity(AppColor.subTextOpacity)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildAsset(asset),
                    ),
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
                        // if (description != '')
                        //   const SizedBox(
                        //     height: 18,
                        //   ),
                        // TITLE
                        Text(
                          title,
                          style: titleStyle,
                        ),

                        if (description != '')
                          const SizedBox(
                            height: 2,
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

  _buildAsset(String asset) {
    if (asset.isEmpty) {
      return Container();
    } else if (asset.contains('https')) {
      return MyNetworkImage(url: asset);
    }
    if (p.extension(asset) == '.svg') {
      return SvgPicture.asset(asset);
    } else {
      return Image.asset(asset, fit: BoxFit.cover);
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
      case 3:
        return 0.04;
      default:
        return 0.04;
    }
  }

  double _getTextFieldWidthFactor(int level) {
    switch (level) {
      case 0:
        return 0.52;
      default:
        return 0.52;
    }
  }

  double _getAssetWidth(int level) {
    switch (level) {
      case 0:
        return 128;
      case 1:
        return 110;
      case 2:
        return 100;
      case 3:
        return 100;
      default:
        return 128;
    }
  }

  double _getAssetHeight(int level) {
    switch (level) {
      case 0:
        return 150;
      case 1:
        return 130;
      case 2:
        return 80;
      case 3:
        return 100;
      default:
        return 150;
    }
  }

  TextStyle? _getTitleStyle(BuildContext context, int level) {
    switch (level) {
      case 0:
        return Theme.of(context).textTheme.headline3;
      case 1:
        return Theme.of(context).textTheme.headline3;
      case 2:
        return Theme.of(context).textTheme.headline4;
      case 3:
        return Theme.of(context).textTheme.headline4;
      default:
        return Theme.of(context).textTheme.headline3;
    }
  }
}
