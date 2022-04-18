import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class HistoryTile extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final Function()? action;

  const HistoryTile({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 6, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: AppColor.textColor,
                          ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: AppColor.textColor
                                .withOpacity(AppColor.subTextOpacity),
                          ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: AppColor.textColor
                                .withOpacity(AppColor.subTextOpacity),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: action,
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Icon(
                  Icons.close_rounded,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
