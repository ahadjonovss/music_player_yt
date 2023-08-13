import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_player_yt/data/models/music_model.dart';

class AudioPlayerPage extends StatefulWidget {
  AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  List<MusicModel> musics = [
    MusicModel(
        cover:
            "https://i.scdn.co/image/ab67616d0000b273b9659e2caa82191d633d6363",
        author: "Konsta",
        musicName: "O'zbekistonlik",
        path: '1.mp3'),
    MusicModel(
        cover:
            "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/8c/81/ae/8c81aec1-6bad-ecd2-691b-e0bbcdb2e600/cover.jpg/1200x1200bb.jpg",
        author: "Konsta & Timur Alixanov",
        musicName: "Odamlar nima deydi?",
        path: '2.mp3'),
  ];

  int currentMusic = 0;
  final player = AudioPlayer();
  Duration maxDuration = const Duration(seconds: 0);
  late ValueListenable<Duration> progress;

  @override
  Widget build(BuildContext context) {
    getMaxDuration() {
      player.getDuration().then((value) {
        maxDuration = value ?? const Duration(seconds: 0);
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Audio Player",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        musics[currentMusic % musics.length].cover,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(musics[currentMusic % musics.length].musicName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
            Text(musics[currentMusic % musics.length].author,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            const SizedBox(height: 20),
            StreamBuilder(
                stream: player.onPositionChanged,
                builder: (context, snapshot) {
                  return ProgressBar(
                    progress: snapshot.data ?? const Duration(seconds: 0),
                    total: maxDuration,
                    onSeek: (duration) {
                      player.seek(duration);
                      setState(() {});
                    },
                  );
                }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      player.stop();
                      player.play(AssetSource(
                          musics[--currentMusic % musics.length].path));
                      getMaxDuration();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 36,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      player.state == PlayerState.playing
                          ? player.pause()
                          : player.play(AssetSource(
                              musics[currentMusic % musics.length].path));
                      getMaxDuration();
                      setState(() {});
                    },
                    icon: Icon(
                      player.state == PlayerState.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      player.stop();
                      player.play(AssetSource(
                          musics[--currentMusic % musics.length].path));
                      getMaxDuration();

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      size: 36,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
