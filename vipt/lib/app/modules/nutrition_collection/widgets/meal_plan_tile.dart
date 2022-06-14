import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:path/path.dart' as p;
import 'package:vipt/app/global_widgets/network_image.dart';

class MealPlanTile extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final Function() onPressed;
  const MealPlanTile({
    Key? key,
    required this.asset,
    required this.title,
    this.description = '',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 36),
              height: maxHeight * 0.36,
              width: maxWidth,
              decoration: BoxDecoration(
                color:
                    AppColor.textFieldFill.withOpacity(AppColor.subTextOpacity),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildAsset(
                asset,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),

            if (description != '')
              const SizedBox(
                height: 2,
              ),
            // DESCRIPTION
            if (description != '')
              Text(
                description,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: AppColor.textColor
                          .withOpacity(AppColor.subTextOpacity),
                    ),
              ),
          ],
        ),
      ),
    );
  }

  _buildAsset(String asset) {
    if (asset.isEmpty) {
      return Container();
    } else if (asset.contains('https')) {
      return MyNetworkImage(
        url: asset,
        fit: BoxFit.fitHeight,
      );
    }
    if (p.extension(asset) == '.svg') {
      return SvgPicture.asset(asset);
    } else {
      return Image.asset(asset, fit: BoxFit.cover);
    }
  }
}
