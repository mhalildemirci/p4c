import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailScreen extends StatefulWidget {
  final String lessonTitle;
  final String videoUrl;
  final String lessonContent;

  const LessonDetailScreen({
    Key? key,
    required this.lessonTitle,
    required this.videoUrl,
    required this.lessonContent,
  }) : super(key: key);

  @override
  _LessonDetailScreenState createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Video ID'sini URL'den çıkarıyoruz
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.lessonTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // YouTube video oynatıcısı
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              width: screenWidth,
              aspectRatio: 16 / 9,
              progressIndicatorColor: Colors.red,
            ),
            // Ders metin içeriği
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.lessonContent,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
