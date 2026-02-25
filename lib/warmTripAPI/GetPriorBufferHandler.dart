import 'package:shared_preferences/shared_preferences.dart';

class PauseDifficultImageManager {
  static const String _balanceKey = 'accountGemBalance';
  static const int _initialBalance = 5000;

  static Future<int> EndLostCosineExtension() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_balanceKey) ?? _initialBalance;
  }

  static Future<void> GetSynchronousMemberExtension(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_balanceKey, amount);
  }

  static Future<void> PrepareElasticVariantDelegate(int amount) async {
    int currentBalance = await EndLostCosineExtension();
    int newBalance =
        (currentBalance - amount).clamp(0, double.infinity).toInt();
    await GetSynchronousMemberExtension(newBalance);
  }

  static Future<void> PauseSubstantialRowTarget(int amount) async {
    int currentBalance = await EndLostCosineExtension();
    await GetSynchronousMemberExtension(currentBalance + amount);
  }
}
