import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_yt/data/models/music_model.dart';
import 'package:music_player_yt/ui/audio_player/audio_player_page.dart';
import 'package:music_player_yt/ui/musics_list/widgets/music_item.dart';

class MusicsListPage extends StatefulWidget {
  MusicsListPage({super.key});

  @override
  State<MusicsListPage> createState() => _MusicsListPageState();
}

class _MusicsListPageState extends State<MusicsListPage> {
  int currentMusic = 0;

  final player = AudioPlayer();
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My List"),
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              if (!isOpened)
                Column(
                  children: [
                    ...List.generate(
                        musics.length,
                        (index) => InkWell(
                            onTap: () {
                              currentMusic = index;
                              isOpened = !isOpened;
                              setState(() {});
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AudioPlayerPage(
                              //               index: index,
                              //               player: player,
                              //               music: musics[index],
                              //             )));
                            },
                            child: MusicItem(music: musics[index])))
                  ],
                )
            ],
          ),
        ),
        bottomNavigationBar: AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.bounceOut,
            height: isOpened ? MediaQuery.of(context).size.height : 100,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            padding: const EdgeInsets.all(16),
            child: isOpened
                ? SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: AudioPlayerPage(
                          onTap: () {
                            isOpened = !isOpened;
                            setState(() {});
                          },
                          index: currentMusic,
                          player: player,
                          music: musics[currentMusic]),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      isOpened = !isOpened;
                      setState(() {});
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      musics[currentMusic].cover))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              musics[currentMusic].musicName,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Text(
                              musics[currentMusic].author,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ],
                        ),
                        Center(
                          child: IconButton(
                              onPressed: () {
                                player.state == PlayerState.playing
                                    ? player.pause()
                                    : player.play(AssetSource(
                                        musics[currentMusic % musics.length]
                                            .path));
                                setState(() {});
                              },
                              icon: Icon(
                                player.state == PlayerState.playing
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 40,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  )));
  }
}
