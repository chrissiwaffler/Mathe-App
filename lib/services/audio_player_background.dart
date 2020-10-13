import 'package:mathe_app/index.dart';

// Implementation als Singelton
class BackgroundAudioPlayer {
  static final BackgroundAudioPlayer _backgroundAudioPlayer = BackgroundAudioPlayer._internal();
  final AssetsAudioPlayer aap = AssetsAudioPlayer.withId("0");
  final String assetsPath = "assets/music/";

  String currentSong;

  factory BackgroundAudioPlayer() {
    _backgroundAudioPlayer.updateSettings();
    // _backgroundAudioPlayer.pause();
    return _backgroundAudioPlayer;
  }

  BackgroundAudioPlayer._internal();

  Future<void> playOrPause() async {
    await aap.playOrPause();
  }

  Future<void> pause() async {
    print("pause");
    await aap.pause();
  }

  Future<void> play() async {
    print("play");
    await aap.play();
  }

  Future<void> updateSettings() async {
    var prefs = await SharedPreferences.getInstance();
    currentSong = prefs.getString('song') ?? "Homework";
    aap.open(
      Audio(
        assetsPath + currentSong + ".mp3"
      ),
      autoStart: false,
    );
    // aap.pause();
  }
}
