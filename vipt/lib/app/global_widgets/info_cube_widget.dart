import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class InfoCubeWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final double width;
  final double height;
  final Color textColor;
  final Color? borderColor;
  final BoxShape? shape;
  final Function()? onTap;
  const InfoCubeWidget({
    Key? key,
    this.color = Colors.grey,
    this.title = '',
    this.subtitle = '',
    this.width = 80,
    this.height = 75,
    this.textColor = Colors.black,
    this.borderColor,
    this.shape,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ScaleTap(
        scaleMinValue: 0.9,
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: borderColor == null
                ? null
                : Border.all(
                    color: borderColor!,
                    width: 5,
                  ),
            color: color,
            borderRadius:
                shape == BoxShape.circle ? null : BorderRadius.circular(5),
            shape: shape ?? BoxShape.rectangle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: textColor),
              ),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
