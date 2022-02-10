import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:path/path.dart' as p;

class ExerciseInCollectionTile extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final Function() onPressed;
  const ExerciseInCollectionTile({
    Key? key,
    required this.asset,
    required this.title,
    this.description = '',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // ASSET
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth * 0.18,
                      maxHeight: constraints.maxWidth * 0.18,
                    ),
                    child: _buildAsset(asset),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.62,
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
}
