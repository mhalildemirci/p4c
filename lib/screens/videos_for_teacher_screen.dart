import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosForTeacherScreen extends StatefulWidget {
  final String videoTitle;
  final String videoUrl;
  final String description;

  const VideosForTeacherScreen({
    Key? key,
    required this.videoTitle,
    required this.videoUrl,
    required this.description,
  }) : super(key: key);

  @override
  _VideosForTeacherScreenState createState() => _VideosForTeacherScreenState();
}

class _VideosForTeacherScreenState extends State<VideosForTeacherScreen> {
  late YoutubePlayerController _controller;

  // "More videos like this" listesi, artık her video için thumbnail eklenmiş
  final List<Map<String, String>> moreVideos = [
    {
      'title': 'Sara Stanley Philosophy for Children Workshops',
      'videoUrl': 'https://www.youtube.com/watch?v=JRz1tsvmFkA',
      'desc':
          'A video created from workshops given with children from Lavender Hill, \n Vrygrond and Khayelitsha, Cape Town, South Africa. ',
      'thumbnail': 'assets/teacher/video_thumb4.png',
    },
    {
      'title': 'What does P4C Look Like in The Classroom?',
      'videoUrl': 'https://www.youtube.com/watch?v=H3sjqvRsw_E',
      'desc':
          'See P4C in action with a class of Year 3 pupils, combined with what the teachers thought!',
      'thumbnail': 'assets/teacher/video_thumb5.png',
    },
    {
      'title':
          'Philosophy, children, and the ageless power of wonder: Dr. Thomas Jackson',
      'videoUrl': 'https://www.youtube.com/watch?v=7AZGLukn0JM',
      'desc':
          'Thomas E. Jackson (Dr. J) earned his doctorate in Comparative Philosophy from\n the University of Hawai`i in 1979. In 1980 he became a co-founder...',
      'thumbnail': 'assets/teacher/video_thumb6.png',
    },
    {
      'title': 'What is Philosophy for Children?',
      'videoUrl': 'https://www.youtube.com/watch?v=ePTBzJMzwhM',
      'desc':
          'Philosophy for Children (Part 4)  by Paul & Doris Cleghorn, \n Aude Consultancy Scotland. This has Teachers asking \nP4C experience to students, giving their own experiences and \nDr Steve Trickey explaining evaluation techniques ',
      'thumbnail': 'assets/teacher/video_thumb7.png',
    },
  ];
  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.videoTitle)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // YouTube video oynatıcısı
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),

            // Mor arkaplanlı, gölgeli açıklama metni
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),

            // More videos heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More videos like this',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Farklı videolar listesi
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: moreVideos.length,
              itemBuilder: (context, index) {
                final mv = moreVideos[index];
                return ListTile(
                  leading: Image.asset(
                    mv['thumbnail']!,
                    width: 120,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(mv['title']!),
                  subtitle: Text(mv['desc']!),
                  onTap: () {
                    // Yeni parametrelerle aynı ekrana tekrar yönlendiriyoruz
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => VideosForTeacherScreen(
                              videoTitle: mv['title']!,
                              videoUrl: mv['videoUrl']!,
                              description: mv['desc']!,
                            ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
