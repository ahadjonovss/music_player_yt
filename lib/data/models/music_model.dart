class MusicModel {
  final String musicName;
  final String author;
  final String cover;
  final String path;

  MusicModel(
      {required this.cover,
      required this.author,
      required this.musicName,
      required this.path});
}

List<MusicModel> musics = [
  MusicModel(
      cover: "https://i.scdn.co/image/ab67616d0000b273b9659e2caa82191d633d6363",
      author: "Konsta",
      musicName: "O'zbekistonlik",
      path: '1.mp3'),
  MusicModel(
      cover:
          "https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/8c/81/ae/8c81aec1-6bad-ecd2-691b-e0bbcdb2e600/cover.jpg/1200x1200bb.jpg",
      author: "Konsta & Timur Alixanov",
      musicName: "Odamlar nima deydi?",
      path: '2.mp3'),
  MusicModel(
      cover:
          "https://cdns-images.dzcdn.net/images/cover/7c99f6bb157544db8775430007bb7979/264x264.jpg",
      author: "Jon Caryl ",
      musicName: "Alone",
      path: '3.mp3'),
  MusicModel(
      cover:
          "https://is3-ssl.mzstatic.com/image/thumb/Music112/v4/9f/a7/98/9fa798ea-25fc-f447-196a-c9f8bc894669/cover.jpg/600x600bf-60.jpg",
      author: "Konsta && Shokir ",
      musicName: "Poyga",
      path: '4.mp3'),
];
