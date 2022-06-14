abstract class Tracker {
  int? id;
  final DateTime date;
  Map<String, dynamic> toMap();

  Tracker({this.id, required this.date});
}
