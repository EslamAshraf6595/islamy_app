import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/domain/sura_states.dart';
import 'package:islamy_app/feature/sura_cubit.dart';
import 'package:islamy_app/ui/quran/resurse/quran_resurse.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';

class SuraContent extends StatefulWidget {
  final int index;
  const SuraContent({super.key, required this.index});

  @override
  State<SuraContent> createState() => _SuraContentState();
}

class _SuraContentState extends State<SuraContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuraCubit()..loadSura(widget.index),
      child: Container(
        color: AppColor.blakeIconElevatedBg,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(QuranResurse.englishQuranList[widget.index]),
            
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppAssets.leftIconSoura),
                    Text(
                      QuranResurse.arabicQuranList[widget.index],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColor.elevatedBg),
                    ),
                    Image.asset(AppAssets.righticonSoura),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<SuraCubit, SuraState>(
                  builder: (context, state) {
                    if (state is SuraLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SuraLoaded) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.all(16.w),
                        child: Text(
                          state.content,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColor.elevatedBg,
                            fontSize: 20.sp,
                          ),
                        ),
                      );
                    } else if (state is SuraError) {
                      return Center(
                        child: Text(
                          "Error: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: Image.asset(
            AppAssets.botuniconSoura,
            width: double.infinity,
            height: 80.h,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
