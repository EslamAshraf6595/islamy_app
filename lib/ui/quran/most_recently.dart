import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/model/most_recent_provider.dart';
import 'package:islamy_app/ui/quran/resurse/quran_resurse.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class MostRecently extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mostRecentlyProvider = Provider.of<MostRecentProvider>(context);
    return mostRecentlyProvider.mostRecentList.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 5.w),
                child: Text("Most Recently",
                    style: TextStyle(color: AppColor.elevatedBg)),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                height: 150.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: mostRecentlyProvider.mostRecentList.length,
                  itemBuilder: (context, index) {
                    final suraIndex =
                        mostRecentlyProvider.mostRecentList[index];
                    return Container(
                      width: 283.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: AppColor.elevatedBg,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(QuranResurse.englishQuranList[suraIndex]),
                              Text(QuranResurse.arabicQuranList[suraIndex]),
                              Text(QuranResurse.ayaNuberList[suraIndex]),
                            ],
                          ),
                          Image.asset(
                            AppAssets.suraImage,
                            width: 151.w,
                            height: 136.h,
                            fit: BoxFit.fill,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                ),
              )
            ],
          );
  }
}
