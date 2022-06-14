import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int moduleCount;
  final List<double> progress;
  final double lineWidth;
  final double lineThickness;
  final double circleSize;
  final double circleIconSize;
  final double circleThickness;

  const CustomProgressIndicator({
    Key? key,
    required this.moduleCount,
    required this.progress,
    this.lineWidth = 40,
    this.lineThickness = 6,
    this.circleSize = 16,
    this.circleIconSize = 12,
    this.circleThickness = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _createModuleIndicatorWidget(moduleCount),
    );
  }

  // Hàm tạo các Indicator dựa trên số lượng module.
  List<Widget> _createModuleIndicatorWidget(int count) {
    return List<Widget>.generate(count + 1, (int index) {
      if (index < count) {
        return Row(
          children: [
            _buildCircleIndicator(
                circleSize, circleIconSize, circleThickness, progress[index]),
            _buildReactangleIndicator(
                lineWidth, lineThickness, progress[index]),
          ],
        );
      }
      if (progress[count - 1] == 1) {
        return _buildCircleIndicator(
            circleSize, circleIconSize, circleThickness, 1);
      } else {
        return _buildCircleIndicator(
            circleSize, circleIconSize, circleThickness, 0);
      }
    });
  }

  // Hàm build Line Indicator.
  Widget _buildReactangleIndicator(
      double width, double thickness, double progress) {
    return Stack(
      children: [
        Container(
          width: width,
          height: thickness,
          decoration: BoxDecoration(
            color: AppColor.progressIndicatorColor,
            shape: BoxShape.rectangle,
          ),
        ),
        Container(
          width: width * progress,
          height: thickness,
          decoration: const BoxDecoration(
            color: AppColor.primaryColor,
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }

  // Hàm build Circle Indicator.
  Widget _buildCircleIndicator(
      double size, double iconSize, double thickness, double progress) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.progressIndicatorColor,
              width: thickness,
            ),
          ),
        ),
        progress > 0
            ? Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: iconSize,
                  color: AppColor.buttonForegroundColor,
                ),
              )
            : Container(),
      ],
    );
  }
}
