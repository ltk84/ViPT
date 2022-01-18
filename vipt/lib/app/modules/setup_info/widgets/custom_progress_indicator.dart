import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int moduleCount;
  final List<double> progress;
  CustomProgressIndicator(
      {Key? key, required this.moduleCount, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildProgressIndicator(),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _createModuleIndicatorWidget(40),
    );
  }

  List<Widget> _createModuleIndicatorWidget(double width) {
    return List<Widget>.generate(moduleCount, (int index) {
      if (index != 0) {
        return Row(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColor.progressIndicatorColor,
                    shape: BoxShape.rectangle,
                  ),
                ),
                Container(
                  width: width * progress[index - 1],
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.rectangle,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColor.progressIndicatorColor,
                    shape: BoxShape.circle,
                  ),
                ),
                progress[index] == 1
                    ? Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check,
                            size: 8, color: AppColor.darkModeTextColor),
                      )
                    : Container(),
              ],
            ),
          ],
        );
      }
      return Stack(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: AppColor.progressIndicatorColor,
              shape: BoxShape.circle,
            ),
          ),
          progress[index] == 1
              ? Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 8,
                    color: AppColor.darkModeTextColor,
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
