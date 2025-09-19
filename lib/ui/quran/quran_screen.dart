import 'package:flutter/material.dart';
import 'package:islamy_app/model/most_recent_provider.dart';
import 'package:islamy_app/main.dart';
import 'package:islamy_app/ui/quran/resurse/quran_resurse.dart';
import 'package:islamy_app/ui/quran/suras_list.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'most_recently.dart';

class QuranScreen extends StatefulWidget {
  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<int> filterIndicesList = List.generate(
    114,
    (index) => index,
  );
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MostRecentProvider>(context, listen: false)
            .refreshMostRecentList());
  }

  @override
  Widget build(BuildContext context) {
    final mostRecentlyProvider = Provider.of<MostRecentProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          TextField(
            onChanged: (text) {
              filterListByNewText(text);
            },
            style: TextStyle(color: AppColor.whiteiconElevatedBg),
            cursorColor: AppColor.elevatedBg,
            decoration: InputDecoration(
              prefixIcon: ImageIcon(
                AssetImage(
                  AppAssets.iconQuran,
                ),
                color: AppColor.elevatedBg,
              ),
              hintText: 'Sure Name',
              hintStyle: TextStyle(color: AppColor.elevatedBg),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8),
                ),
                borderSide: BorderSide(color: AppColor.elevatedBg),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColor.elevatedBg),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppColor.elevatedBg),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          MostRecently(),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Text(
              "Suras List",
              style: TextStyle(color: AppColor.elevatedBg),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Expanded(
            child: SurasList(
              filteredIndices: filterIndicesList,
            ),
          ),
        ],
      ),
    );
  }

  void filterListByNewText(String newText) {
    List<int> filterList = [];
    for (int i = 0; i < QuranResurse.englishQuranList.length; i++) {
      if (QuranResurse.englishQuranList[i]
          .toLowerCase()
          .contains(newText.toLowerCase())) {
        filterList.add(i);
      } else if (QuranResurse.arabicQuranList[i].contains(newText)) {
        filterList.add(i);
      }
      filterIndicesList = filterList;
      setState(() {});
    }
  }
}
