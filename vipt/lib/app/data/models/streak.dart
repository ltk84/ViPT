class Streak {
  int? id;
  final DateTime date;
  bool value;
  final int planID;

  Streak(
      {this.id, required this.date, required this.value, required this.planID});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'value': value,
      'planID': planID,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory Streak.fromMap(Map<String, dynamic> map) {
    return Streak(
      id: map['id']?.toInt(),
      planID: map['planID']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      value: map['value'] == 1 ? true : false,
    );
  }
}
