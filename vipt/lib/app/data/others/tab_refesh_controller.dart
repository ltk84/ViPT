class RefeshTabController {
  RefeshTabController._privateConstructor();

  static final RefeshTabController instance =
      RefeshTabController._privateConstructor();

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static bool _planTabNeedToUpdate = false;
  static bool _dailyTabNeedToUpdate = false;
  static bool _libraryTabNeedToUpdate = false;
  static bool _profileTabNeedToUpdate = false;

  bool get isPlanTabNeedToUpdate => _planTabNeedToUpdate;
  bool get isDailyTabNeedToUpdate => _dailyTabNeedToUpdate;
  bool get isLibraryTabNeedToUpdate => _libraryTabNeedToUpdate;
  bool get isProfileTabNeedToUpdate => _profileTabNeedToUpdate;

  void togglePlanTabUpdate() => _planTabNeedToUpdate = !_planTabNeedToUpdate;
  void toggleDailyTabUpdate() => _dailyTabNeedToUpdate = !_dailyTabNeedToUpdate;
  void toggleLibraryTabUpdate() =>
      _libraryTabNeedToUpdate = !_libraryTabNeedToUpdate;
  void toggleProfileTabUpdate() =>
      _profileTabNeedToUpdate = !_profileTabNeedToUpdate;
}
