import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/water_track_provider.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyWaterController extends GetxController with TrackerController {
  final _provider = WaterTrackProvider();
  Rx<int> waterVolume = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await fetchTracksByDate(DateTime.now());
    isLoading.value = false;
  }

  @override
  fetchTracksByDate(DateTime date) async {
    this.date = date;
    tracks = await _provider.fetchByDate(date);
    waterVolume.value = 0;
    tracks.map((e) {
      e = e as WaterTracker;
      waterVolume.value += e.waterVolume;
    }).toList();
    update();
  }

  addTrack(int volume) async {
    waterVolume.value += volume;
    WaterTracker wt = WaterTracker(
        date: DateUtils.isSameDay(date, DateTime.now()) ? DateTime.now() : date,
        waterVolume: volume);
    wt = await _provider.add(wt);
    tracks.add(wt);
    update();

    _markRelevantTabToUpdate();
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }
  }

  deleteTrack(WaterTracker wt) async {
    final result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          label: 'Xóa log nước uống',
          content:
              'Bạn có chắc chắn muốn xóa log này? Bạn sẽ không thể hoàn tác lại thao tác này.',
          labelCancel: 'Không',
          labelOk: 'Có',
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () {
            Navigator.of(context).pop(OkCancelResult.ok);
          },
          primaryButtonColor: AppColor.waterBackgroundColor,
          buttonFactorOnMaxWidth: 0.32,
          buttonsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );

    if (result == OkCancelResult.ok) {
      waterVolume.value -= wt.waterVolume;
      tracks.remove(wt);
      await _provider.delete(wt.id ?? 0);
      update();

      _markRelevantTabToUpdate();
    }
  }
}
