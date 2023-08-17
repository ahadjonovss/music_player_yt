import 'package:flutter/material.dart';
import 'package:music_player_yt/data/models/music_model.dart';

class MusicItem extends StatelessWidget {
  MusicModel music;
  MusicItem({required this.music, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(music.cover))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                music.musicName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                music.author,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(0.7)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
