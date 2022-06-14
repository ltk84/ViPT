import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData iconData;
  final Function()? onPressed;
  final String hero;
  final EdgeInsets padding;
  const AppBarIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.hero,
    this.padding = const EdgeInsets.fromLTRB(8, 8, 8, 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .backgroundColor
                  .withOpacity(AppColor.subTextOpacity),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 20,
              color: Theme.of(context).backgroundColor,
              icon: Hero(
                tag: hero,
                child: Icon(
                  iconData,
                  color: AppColor.textColor,
                ),
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
