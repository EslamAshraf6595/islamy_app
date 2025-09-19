import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbeehProvider extends ChangeNotifier {
  double turnSpeh = 0;
  final int totalBeads = 33;
  int count = 0;
  int currentZikrIndex = 0;

  final List<String> azkar = [
    "سُبْحَانَ الله",
    "الْحَمْدُ لِلَّه",
    "اللَّهُ أَكْبَر",
    "لا إله إلا الله",
  ];

  TasbeehProvider() {
    _loadTasbeehData();
  }

  Future<void> _loadTasbeehData() async {
    final prefs = await SharedPreferences.getInstance();
    count = prefs.getInt("tasbeeh_count") ?? 0;
    currentZikrIndex = prefs.getInt("tasbeeh_zikr_index") ?? 0;
    turnSpeh = count / totalBeads;
    notifyListeners();
  }

  Future<void> _saveTasbeehData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("tasbeeh_count", count);
    await prefs.setInt("tasbeeh_zikr_index", currentZikrIndex);
  }

  void rotateSebha() {
    turnSpeh += 1 / totalBeads;
    count++;

    if (count >= totalBeads) {
      count = 0;
      currentZikrIndex = (currentZikrIndex + 1) % azkar.length;
    }

    _saveTasbeehData();
    notifyListeners();
  }

  Future<void> resetSebha() async {
    turnSpeh = 0;
    count = 0;
    currentZikrIndex = 0;
    await _saveTasbeehData();
    notifyListeners();
  }
}
