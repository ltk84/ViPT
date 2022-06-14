import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';

class NetworkImageBackgroundContainer extends StatelessWidget {
  final Widget child;
  final String imageURL;
  const NetworkImageBackgroundContainer(
      {Key? key, required this.child, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageURL,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, loadingProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
              value: loadingProgress.progress,
            ),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              return ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  Container(
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.15),
                    padding: AppDecoration.screenPadding
                        .copyWith(top: 24, bottom: 0),
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
        });
  }
}
