import 'package:flutter/material.dart';
import 'package:islamy_app/utils/CustomBottomNavigationBarItem.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:islamy_app/utils/lists.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  ListsApp listsApp = ListsApp();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ListsApp.backgroundImages[selectedIndex],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: AppColor.elevatedBg,
            ),
            child: BottomNavigationBar(
              // backgroundColor: AppColor.elevatedBg,
              // type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              selectedItemColor: AppColor.whiteiconElevatedBg,
              unselectedItemColor: AppColor.blakeIconElevatedBg,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              items: [
                CustomBottomNavigationBarItem(
                    index: 0,
                    label: "Quran",
                    iconImage: AppAssets.iconQuran,
                    selectedIndex: selectedIndex),
                CustomBottomNavigationBarItem(
                    index: 1,
                    label: "Hadeth",
                    iconImage: AppAssets.hadeth,
                    selectedIndex: selectedIndex),
                CustomBottomNavigationBarItem(
                    index: 2,
                    label: "Sebha",
                    iconImage: AppAssets.taspeh,
                    selectedIndex: selectedIndex),
                CustomBottomNavigationBarItem(
                    index: 3,
                    label: "Radio",
                    iconImage: AppAssets.radio,
                    selectedIndex: selectedIndex),
                CustomBottomNavigationBarItem(
                    index: 4,
                    label: "Time",
                    iconImage: AppAssets.time,
                    selectedIndex: selectedIndex),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.botuniconSoura,
              ),
              Expanded(child: ListsApp.screens[selectedIndex])
            ],
          ),
        ),
      ],
    );
  }
}
