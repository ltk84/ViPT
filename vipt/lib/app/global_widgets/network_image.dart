import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class MyNetworkImage extends StatelessWidget {
  final String url;
  const MyNetworkImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
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
    );
  }
}
