import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  List musics = [];

  someName() async {
    await Permission.storage.request();
    bool isGranted = await Permission.storage.isGranted;
    print(isGranted);
    if (isGranted) {
      print('Salom');
      final OnAudioQuery _audioQuery = OnAudioQuery();
      // Query Audios
      List audios = await _audioQuery.querySongs();
      print(audios);
      print("MAANAANAA");

      // Query Albums
      List<AlbumModel> albums = await _audioQuery.queryAlbums();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        someName();
      }),
    );
  }
}
