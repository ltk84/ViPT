import 'package:vipt/app/data/models/tracker.dart';

class WaterTracker extends Tracker {
  num waterVolume;

  WaterTracker({int? id, required DateTime date, required this.waterVolume})
      : super(id: id, date: date);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': super.date,
      'waterVolume': waterVolume,
    };

    if (super.id != null) {
      map['id'] = super.id;
    }

    return map;
  }

  factory WaterTracker.fromMap(Map<String, dynamic> map) {
    return WaterTracker(
        id: map['id'] ?? 0,
        waterVolume: map['waterVolume'] ?? 0,
        date: map['date'] ?? DateTime.now());
  }
}
