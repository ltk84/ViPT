import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';
import 'package:vipt/app/modules/session/session_controller.dart';
import 'package:vipt/app/modules/session/widgets/complete_indicator_display_widget.dart';

class CompleteSessionScreen extends StatelessWidget {
  CompleteSessionScreen({Key? key}) : super(key: key);

  final _controller = Get.find<SessionController>();

  void backToDetailScreen() {
    Get.back();
    Get.back();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backToDetailScreen();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.secondaryColor,
          onPressed: () {
            backToDetailScreen();
          },
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              'Xong'.tr,
              style: Theme.of(context).textTheme.button,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            _buildAsset(_controller.currentCollection.asset),
            Container(color: AppColor.completeSessionFilterColor),
            Container(color: AppColor.completeSessionSecondaryFilterColor),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.0, -0.85),
                  end: const Alignment(0.0, 1.0),
                  colors: [
                    Colors.white.withOpacity(1.0),
                    Colors.white.withOpacity(0.79),
                    Colors.white.withOpacity(0.58),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
            ),
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                  padding:
                      AppDecoration.screenPadding.copyWith(top: 24, bottom: 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: IntroCollectionWidget(
                            title: "HOÀN THÀNH".tr,
                            description:
                                "Chúc mừng bạn đã hoàn thành bộ luyện tập này"
                                    .tr),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CompleteIndicatorDisplayWidget(
                        timeString:
                            _controller.timeConsumed.toPrecision(2).toString(),
                        exerciseCountString: '100',
                        caloString:
                            _controller.caloConsumed.toPrecision(2).toString(),
                      ),
                      SizedBox(
                        height:
                            Theme.of(context).textTheme.button!.fontSize! * 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildAsset(String imageURL) {
    if (imageURL.isURL) {
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
            );
          });
    } else {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(JPGAssetString.userWorkoutCollection),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
