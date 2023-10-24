import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> completeUserOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_prefsKey, true);
  }

  static Future<bool> getIsOnBoardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final isOnboardingCompleted = prefs.getBool(_prefsKey);
    return isOnboardingCompleted ?? false;
  }
}

const String _prefsKey = 'onboarding';
