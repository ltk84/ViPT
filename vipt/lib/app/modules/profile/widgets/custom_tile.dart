import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class CustomTile extends StatelessWidget {
  final String asset;
  final String title;
  final String description;
  final Function() onPressed;
  const CustomTile(
      {Key? key,
      required this.asset,
      required this.title,
      this.description = '',
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      maxWidth: constraints.maxWidth * 0.30,
                    ),
                    child: Image.asset(asset),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.04,
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.56,
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
}
