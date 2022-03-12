import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/values.dart';

class AssetImageBackgroundContainer extends StatelessWidget {
  final Widget child;
  final String imageURL;
  const AssetImageBackgroundContainer(
      {Key? key, required this.child, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage(imageURL),
          fit: BoxFit.cover,
        ),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Container(
              margin: EdgeInsets.only(top: constraints.maxHeight * 0.15),
              padding: AppDecoration.screenPadding.copyWith(top: 24, bottom: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: child,
            ),
          ],
        );
      }),
    );
  }
}
