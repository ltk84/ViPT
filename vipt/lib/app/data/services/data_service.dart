import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/providers/user_provider.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();

  final _userProvider = UserProvider();

  Future<ViPTUser> createUser(ViPTUser user) async {
    return await _userProvider.add(user);
  }
}
