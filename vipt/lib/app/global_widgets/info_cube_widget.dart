import 'package:flutter/material.dart';

class InfoCubeWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final double width;
  final double height;
  final Color textColor;
  const InfoCubeWidget(
      {Key? key,
      this.color = Colors.grey,
      this.title = '',
      this.subtitle = '',
      this.width = 80,
      this.height = 75,
      this.textColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
    );
  }
}
