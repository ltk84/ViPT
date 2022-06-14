import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class CustomDraggableWidget extends StatelessWidget {
  final Widget child;
  const CustomDraggableWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      feedback: Container(
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowColor,
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: child,
      ),
      childWhenDragging: Container(),
      child: child,
    );
  }
}
