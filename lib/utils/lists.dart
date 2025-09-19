import 'package:flutter/material.dart';
import 'package:islamy_app/ui/hadeth/hadeth_screen.dart';
import 'package:islamy_app/ui/quran/quran_screen.dart';
import 'package:islamy_app/ui/radio/radio_screen.dart';
import 'package:islamy_app/ui/taspeh/taspeh_screen.dart';
import 'package:islamy_app/ui/time/time_screen.dart';

class ListsApp {
  static const List<String> backgroundImages = [
    'assets/images/qurain1.png',
    'assets/images/hadeth1.png',
    'assets/images/taspeh1.png',
    'assets/images/radio1.png',
    'assets/images/time1.png',
  ];
  static List<Widget> screens = [
    QuranScreen(),
    HadethScreen(),
    TaspehScreen(),
    RadioScreen(),
    TimeScreen(),
  ];
}
