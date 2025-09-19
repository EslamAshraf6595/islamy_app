import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/Api/api_server_reciters.dart';
import 'package:islamy_app/api/api_service_radio.dart';
import 'package:islamy_app/model/RadioModel.dart';
import 'package:islamy_app/model/RecitersModel.dart';
import 'package:islamy_app/model/audio_provider.dart';
import 'package:islamy_app/ui/radio/radio_tab.dart';
import 'package:islamy_app/ui/radio/reciters_tab.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  int index = 0;

  late Future<RadioModel?> radiosFuture;
  late Future<RecitersModel?> recitersFuture;

  @override
  void initState() {
    super.initState();
    radiosFuture = ApiServiceRadio().fetchRadios(radio: 'radios');
    recitersFuture = ApiServerReciters().fetchdReciterData();
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Column(
        children: [
          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab('Radio', 0),
              SizedBox(width: 5.w),
              _buildTab('Reciters', 1),
            ],
          ),
          SizedBox(height: 5.h),

          // Content
          Expanded(
            child: index == 0
                ? RadioTab(radiosFuture: radiosFuture, audioProvider: audioProvider)
                : RecitersTab(recitersFuture: recitersFuture, audioProvider: audioProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int tabIndex) {
    return GestureDetector(
      onTap: () => setState(() => index = tabIndex),
      child: Container(
        height: 40.h,
        width: 185.w,
        decoration: BoxDecoration(
          color: index == tabIndex
              ? AppColor.elevatedBg
              : AppColor.blakeIconElevatedBg,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: index == tabIndex ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
