

import 'package:audioplayers/audioplayers.dart';

void playCorrectSound() async {
  final player = AudioPlayer();
  const soundPath = "audio/success.mp3";
  await player.play(AssetSource(soundPath), volume: 0.5);
}

void playWrongSound() async {
  final player = AudioPlayer();
  const soundPath = "audio/wrong.mp3";
  await player.play(AssetSource(soundPath));
}




