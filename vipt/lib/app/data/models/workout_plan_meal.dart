// class WorkoutPlanMeal {
//   final int? id;
//   final DateTime date;
//   final String mealID;

//   WorkoutPlanMeal({
//     this.id,
//     required this.date,
//     required this.mealID,
//   });

//   Map<String, dynamic> toMap() {
//     Map<String, dynamic> map = {
//       'id': id,
//       'date': date.toString(),
//       'mealID': mealID,
//     };

//     if (id != null) {
//       map['id'] = id;
//     }

//     return map;
//   }

//   factory WorkoutPlanMeal.fromMap(Map<String, dynamic> map) {
//     return WorkoutPlanMeal(
//       id: map['id']?.toInt(),
//       date: DateTime.parse(map['date']),
//       mealID: map['mealID'] ?? '',
//     );
//   }

//   @override
//   String toString() => 'WorkoutPlanMeal(id: $id, date: $date, mealID: $mealID)';
// }
