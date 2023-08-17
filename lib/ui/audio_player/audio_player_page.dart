import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_player_yt/data/models/music_model.dart';

class AudioPlayerPage extends StatefulWidget {
  MusicModel music;
  AudioPlayer player;
  int index;
  VoidCallback onTap;
  AudioPlayerPage(
      {required this.index,
      required this.player,
      required this.music,
      required this.onTap,
      super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  Duration maxDuration = const Duration(seconds: 0);
  late ValueListenable<Duration> progress;

  @override
  void initState() {
    widget.player.play(AssetSource(musics[widget.index % musics.length].path));
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMaxDuration() {
      widget.player.getDuration().then((value) {
        maxDuration = value ?? const Duration(seconds: 0);
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onTap,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
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
                        musics[widget.index % musics.length].cover,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(musics[widget.index % musics.length].musicName,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
            Text(musics[widget.index % musics.length].author,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 16)),
            const SizedBox(height: 20),
            StreamBuilder(
                stream: widget.player.onPositionChanged,
                builder: (context, snapshot) {
                  return ProgressBar(
                    progress: snapshot.data ?? const Duration(seconds: 0),
                    total: maxDuration,
                    onSeek: (duration) {
                      widget.player.seek(duration);
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
                      widget.player.stop();
                      widget.player.play(AssetSource(
                          musics[--widget.index % musics.length].path));
                      getMaxDuration();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 36,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      widget.player.state == PlayerState.playing
                          ? widget.player.pause()
                          : widget.player.play(AssetSource(
                              musics[widget.index % musics.length].path));
                      getMaxDuration();
                      setState(() {});
                    },
                    icon: Icon(
                      widget.player.state == PlayerState.playing
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      widget.player.stop();
                      widget.player.play(AssetSource(
                          musics[--widget.index % musics.length].path));
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
