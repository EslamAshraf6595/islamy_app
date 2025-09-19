import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/model/most_recent_provider.dart';
import 'package:islamy_app/ui/quran/resurse/quran_resurse.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:islamy_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

class SurasList extends StatelessWidget {
  final List<int> filteredIndices;

  const SurasList({super.key, required this.filteredIndices});

  @override
  Widget build(BuildContext context) {
    final mostRecentlyProvider = Provider.of<MostRecentProvider>(context);
    return Expanded(
      child: ListView.separated(
        itemCount: filteredIndices.length,
        itemBuilder: (context, listIndex) {
          final suraIndex = filteredIndices[listIndex]; // actual sura index

          return GestureDetector(
            onTap: () {
              mostRecentlyProvider.updateMostRecentIndicesList(suraIndex);
              Navigator.pushNamed(
                context,
                AppRoutes.sura_content,
                arguments: suraIndex,
              );
            },
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppAssets.suraNumber),
                    Text(
                      "${suraIndex + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      QuranResurse.englishQuranList[suraIndex],
                      style: TextStyle(color: AppColor.whiteiconElevatedBg),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      QuranResurse.ayaNuberList[suraIndex],
                      style: TextStyle(color: AppColor.whiteiconElevatedBg),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  QuranResurse.arabicQuranList[suraIndex],
                  style: TextStyle(color: AppColor.whiteiconElevatedBg),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            thickness: 2,
            indent: 40.w,
            endIndent: 50.w,
          );
        },
      ),
    );
  }
}
