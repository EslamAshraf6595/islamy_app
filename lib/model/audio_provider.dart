import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  int? _playingIndex;
  bool _isMuted = false;
  double _volume = 1.0;

  int? get playingIndex => _playingIndex;
  bool get isMuted => _isMuted;
  double get volume => _volume;

  Future<void> play(String url, int index) async {
    await _player.setUrl(url);
    await _player.setVolume(_volume);
    await _player.play();
    _playingIndex = index;
    _isMuted = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await _player.stop();
    _playingIndex = null;
    notifyListeners();
  }

  Future<void> toggleMute() async {
    if (_playingIndex != null) {
      if (_isMuted) {
        await _player.setVolume(_volume);
      } else {
        await _player.setVolume(0.0);
      }
      _isMuted = !_isMuted;
      notifyListeners();
    }
  }

  Future<void> changeVolume(double value) async {
    _volume = value;
    if (!_isMuted) {
      await _player.setVolume(_volume);
    }
    notifyListeners();
  }

  void disposePlayer() {
    _player.dispose();
  }
}
