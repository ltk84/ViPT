import 'dart:convert';

import 'package:vipt/app/data/models/base_model.dart';

class WorkoutCollection extends BaseModel {
  final String title;
  final List<String> workoutIDs;
  final int time;
  final int calo;
  final int round;
  final bool isStartWithWarmUp;
  final bool isShuffle;
  final int exerciseTime;
  final int transitionTime;
  final int restTime;
  final int restFrequency;

  WorkoutCollection(
    String? id, {
    required this.title,
    required this.workoutIDs,
    required this.time,
    required this.calo,
    required this.round,
    required this.isStartWithWarmUp,
    required this.isShuffle,
    required this.exerciseTime,
    required this.transitionTime,
    required this.restTime,
    required this.restFrequency,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'workoutIDs': workoutIDs,
      'time': time,
      'calo': calo,
      'round': round,
      'isStartWithWarmUp': isStartWithWarmUp,
      'isShuffle': isShuffle,
      'exerciseTime': exerciseTime,
      'transitionTime': transitionTime,
      'restTime': restTime,
      'restFrequency': restFrequency,
    };
  }

  factory WorkoutCollection.fromMap(String id, Map<String, dynamic> map) {
    return WorkoutCollection(
      id,
      title: map['title'] ?? '',
      workoutIDs: List<String>.from(map['workoutIDs']),
      time: map['time']?.toInt() ?? 0,
      calo: map['calo']?.toInt() ?? 0,
      round: map['round']?.toInt() ?? 0,
      isStartWithWarmUp: map['isStartWithWarmUp'] ?? false,
      isShuffle: map['isShuffle'] ?? false,
      exerciseTime: map['exerciseTime']?.toInt() ?? 0,
      transitionTime: map['transitionTime']?.toInt() ?? 0,
      restTime: map['restTime']?.toInt() ?? 0,
      restFrequency: map['restFrequency']?.toInt() ?? 0,
    );
  }
}
