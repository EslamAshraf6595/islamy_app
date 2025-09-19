import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefkeys {
  static const String mostRecentKey = "most_recent_suras";
}

class MostRecentProvider extends ChangeNotifier {
  List<int> mostRecentList = [];

  Future<void> refreshMostRecentList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentSura =
        prefs.getStringList(Prefkeys.mostRecentKey) ?? [];

    mostRecentList = mostRecentSura.map((element) => int.parse(element)).toList();
    notifyListeners();
  }

  Future<void> updateMostRecentIndicesList(int newSuraIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mostRecentIndicesList =
        prefs.getStringList(Prefkeys.mostRecentKey) ?? [];

    if (mostRecentIndicesList.contains('$newSuraIndex')) {
      mostRecentIndicesList.remove('$newSuraIndex');
    }
    mostRecentIndicesList.insert(0, '$newSuraIndex');

    if (mostRecentIndicesList.length > 5) {
      mostRecentIndicesList.removeLast();
    }

    await prefs.setStringList(Prefkeys.mostRecentKey, mostRecentIndicesList);
    await refreshMostRecentList();
  }
}
