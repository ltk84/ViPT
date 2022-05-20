import 'package:flutter/material.dart';

class CameraButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final IconData? iconData;
  const CameraButton(
      {Key? key, this.onPressed, this.title = 'Chụp ảnh', this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(iconData ?? Icons.camera_alt_rounded),
              const SizedBox(
                height: 4,
              ),
              Text(title, style: Theme.of(context).textTheme.bodyText2),
            ],
          ),
        ),
      ),
    );
  }
}
