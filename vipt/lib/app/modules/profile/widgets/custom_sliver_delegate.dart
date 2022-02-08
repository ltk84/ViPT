import 'package:flutter/material.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final List<Widget>? action;
  final Color backgroundColor;
  final Widget child;
  final double childSize;
  CustomSliverDelegate({
    required this.expandedHeight,
    this.action,
    required this.backgroundColor,
    required this.child,
    this.childSize = 150,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double opacity = 1 - shrinkOffset / (expandedHeight - childSize / 2);
    double top = expandedHeight - childSize / 2 - shrinkOffset;
    double left = MediaQuery.of(context).size.width / 4;
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          actions: action,
        ),
        Positioned(
          top: top,
          left: left,
          child: Opacity(
            opacity: opacity < 0 ? 0 : opacity,
            child: SizedBox(
              height: childSize,
              width: MediaQuery.of(context).size.width / 2,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
