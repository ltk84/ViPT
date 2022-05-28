import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  const CustomSlider({Key? key, this.value = 1}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Hệ số',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _value.toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    setState(() {
                      _value = 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Text(
                      'Reset',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColor.textColor
                                .withOpacity(AppColor.subTextOpacity),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          },
          min: 0.1,
          max: 100,
          activeColor: AppColor.nutriBackgroundColor,
          inactiveColor: AppColor.nutriBackgroundColor
              .withOpacity(AppColor.subTextOpacity),
          thumbColor: AppColor.accentTextLightColor,
        ),
      ],
    );
  }
}
