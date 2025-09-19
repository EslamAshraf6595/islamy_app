import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/model/RadioModel.dart';
import 'package:islamy_app/model/audio_provider.dart';
import 'package:islamy_app/ui/radio/radio_details.dart';


class RadioTab extends StatelessWidget {
  final Future<RadioModel?> radiosFuture;
  final AudioProvider audioProvider;

  const RadioTab({
    super.key,
    required this.radiosFuture,
    required this.audioProvider,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RadioModel?>(
      future: radiosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.radios == null) {
          return const Center(child: Text("No radios found"));
        }

        final radios = snapshot.data!.radios!;

        return ListView.builder(
          itemCount: radios.length,
          padding: EdgeInsets.symmetric(vertical: 5.h),
          itemBuilder: (context, i) {
            final radio = radios[i];
            return Column(
              children: [
                RadioDetails(
                  title: radio.name ?? "Unknown",
                  isPlaying: audioProvider.playingIndex == i,
                  isMuted: audioProvider.playingIndex == i && audioProvider.isMuted,
                  onPlayPause: () {
                    if (audioProvider.playingIndex == i) {
                      audioProvider.stop();
                    } else {
                      audioProvider.play(radio.url ?? "", i);
                    }
                  },
                  onMuteUnmute: audioProvider.toggleMute,
                ),
                if (audioProvider.playingIndex == i)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: Slider(
                      value: audioProvider.volume,
                      min: 0.0,
                      max: 1.0,
                      divisions: 10,
                      onChanged: (val) => audioProvider.changeVolume(val),
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
