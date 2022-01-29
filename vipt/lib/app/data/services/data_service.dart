import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/providers/workout_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();
  static late ViPTUser currentUser;
  static late List<Workout> workoutList;

  final _userProvider = UserProvider();
  final _workoutProvider = WorkoutProvider();

  Future<ViPTUser> createUser(ViPTUser user) async {
    currentUser = await _userProvider.add(user);
    return currentUser;
  }

  Future<void> loadUserData() async {
    currentUser =
        await _userProvider.fetch(AuthService.instance.currentUser!.uid);
  }

  loadWorkoutList() async {
    workoutList = await _workoutProvider.fetchAll();
  }
}
