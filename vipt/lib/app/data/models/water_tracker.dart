import 'package:vipt/app/data/models/tracker.dart';

class WaterTracker extends Tracker {
  num waterVolume;

  WaterTracker({required DateTime date, required this.waterVolume})
      : super(date);

  @override
  void updateToDB() {
    // TODO: implement updateToDB
  }
}
