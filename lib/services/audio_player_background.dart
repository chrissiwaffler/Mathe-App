import 'package:mathe_app/index.dart';

// Implementation als Singelton
class BackgroundAudioPlayer {
  static final BackgroundAudioPlayer _backgroundAudioPlayer = BackgroundAudioPlayer._internal();
  final AssetsAudioPlayer aap = AssetsAudioPlayer();
  final String assetsPath = "assets/music/";

  String currentSong;

  factory BackgroundAudioPlayer() {
    _backgroundAudioPlayer.updateSettings();
    _backgroundAudioPlayer.play();
    return _backgroundAudioPlayer;
  }

  BackgroundAudioPlayer._internal();

  void playOrPause() {
    aap.playOrPause();
  }

  void pause() {
    aap.pause();
  }

  void play() {
    aap.play();
  }

  Future<void> updateSettings() async {
    var prefs = await SharedPreferences.getInstance();
    currentSong = prefs.getString('song') ?? "Homework";
    aap.open(
      Audio(
        assetsPath + currentSong + ".mp3"
      )
    );
  }
}
