import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';

class RadioDetails extends StatelessWidget {
  final String title;
  final bool isPlaying;
  final bool isMuted;
  final VoidCallback onPlayPause;
  final VoidCallback onMuteUnmute;

  const RadioDetails({
    super.key,
    required this.title,
    required this.isPlaying,
    required this.isMuted,
    required this.onPlayPause,
    required this.onMuteUnmute,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 141.h,
          width: 391.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColor.elevatedBg,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Positioned(
          bottom: 0.h,
          left: 10.w,
          right: 10.w,
          child: Image.asset(
            isPlaying ? AppAssets.frequency : AppAssets.botuniconSoura,
            color: AppColor.balck,
            height: 97.h,
            width: 391.w,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 18,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          left: 180.5.w,
          child: GestureDetector(
            onTap: onPlayPause,
            child: Image.asset(
              isPlaying ? AppAssets.runsound : AppAssets.polygon,
              width: 27.w,
              height: 32.87.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          right: 170.w,
          child: GestureDetector(
            onTap: onMuteUnmute,
            child: Image.asset(
              isMuted ? AppAssets.mute : AppAssets.volum,
              width: 27.w,
              height: 32.87.h,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
