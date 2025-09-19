import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/model/RecitersModel.dart';
import 'package:islamy_app/model/audio_provider.dart';
import 'package:islamy_app/ui/radio/radio_details.dart';


class RecitersTab extends StatelessWidget {
  final Future<RecitersModel?> recitersFuture;
  final AudioProvider audioProvider;

  const RecitersTab({
    super.key,
    required this.recitersFuture,
    required this.audioProvider,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecitersModel?>(
      future: recitersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.reciters == null) {
          return const Center(child: Text("No reciters found"));
        }

        final reciters = snapshot.data!.reciters!;

        return ListView.builder(
          itemCount: reciters.length,
          padding: EdgeInsets.symmetric(vertical: 5.h),
          itemBuilder: (context, i) {
            final reciter = reciters[i];

            return Column(
              children: [
                RadioDetails(
                  title: reciter.name ?? "Unknown Reciter",
                  isPlaying: audioProvider.playingIndex == i,
                  isMuted: audioProvider.playingIndex == i && audioProvider.isMuted,
                  onPlayPause: () {
                    if (reciter.moshaf != null && reciter.moshaf!.isNotEmpty) {
                      final moshaf = reciter.moshaf!.first;
                      final url = "${moshaf.server}001.mp3"; // Surah Al-Fatiha

                      if (audioProvider.playingIndex == i) {
                        audioProvider.stop();
                      } else {
                        audioProvider.play(url, i);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No moshaf available for ${reciter.name}")),
                      );
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
