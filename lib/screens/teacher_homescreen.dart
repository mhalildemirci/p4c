import 'package:edu_p4c/screens/teacher_notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:edu_p4c/screens/videos_for_teacher_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  // Önerilen videolar (örnek veriler)
  final List<Map<String, String>> recommendedVideos = [
    {
      'title': 'P4C for Kids #1',
      'thumbnail': 'assets/teacher/video_thumb1.png',
      'videoUrl': 'https://www.youtube.com/watch?v=eMviXkkd-T4',
      'desc':
          'The most important factor in teaching \nphilosophical education to children is \nthe involvement of the child. \neducational and interesting topics \nshould be chosen for children and \nshould stimulate them to think.\nIn everyday life, children should \ndiscuss the topics they have learnt in \nlessons with their environment and \nexperience different ideas.',
    },
    {
      'title': 'P4C for Kids #2',
      'thumbnail': 'assets/teacher/video_thumb2.png',
      'videoUrl': 'https://www.youtube.com/watch?v=yPx-v9LT4w4',
      'desc':
          'this video was created by Michael Siegmund and presents his p4c experiences.',
    },
    {
      'title': 'P4C for Kids #3',
      'thumbnail': 'assets/teacher/video_thumb3.png',
      'videoUrl': 'https://www.youtube.com/watch?v=mnt-XFg90Jk',
      'desc':
          'An introduction to Philosophy for Children (P4C), featuring SAPEREs \nDirector of Philosophy and Education, Grace Lockrobin, \nalong with the pupils and staff at Emmaus Primary School, \nSheffield."P4C has had a massive impact on the school and \nthe culture; the way they speak even outside \nof the classroom. Also, its helped with their understanding of \nthe world and different contexts..." — Pamela Shaw, Y1 Teacher',
    },
  ];

  // Blog önerileri (örnek veriler)
  final List<Map<String, String>> blogPosts = [
    {
      'title': 'What research says?',
      'description':
          'In a study conducted to increase \n the participation of students in courses \n related to philosophy, \n it was found that students...',
      'link':
          'https://educationendowmentfoundation.org.uk/projects-and-evaluation/projects/philosophy-for-children-effectiveness-trial',
      'thumbnail': 'assets/teacher_blog.png',
    },
    {
      'title': 'What is P4C?',
      'description':
          'Philosophy for Children approach that students... \n develop reasoning and judgement skills through dialogue.',
      'link':
          'https://school-education.ec.europa.eu/en/etwinning/projects/p4c-notice-think-discuss/twinspace/pages/about-p4c',
      'thumbnail': 'assets/teacher_blog2.png',
    },
    {
      'title': 'New philosophy for a new generation',
      'description':
          'A generation more open-minded to critical thinking... \n is emerging and needs new tools.',
      'link':
          'https://blog.rootsofprogress.org/why-a-new-philosophy-of-progress',
      'thumbnail': 'assets/teacher_blog3.png',
    },
  ];

  // Blog linkini harici tarayıcıda açmak için
  Future<void> _openBlogLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Link açılamazsa hata ver
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cannot open link.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bildirim ikonu
      appBar: AppBar(
        title: const Text('Related videos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TeacherNotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Yatay scroll: sadece resim kartları
            SizedBox(
              height: 140, // Kartların yüksekliği
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedVideos.length,
                itemBuilder: (context, index) {
                  final video = recommendedVideos[index];
                  return GestureDetector(
                    onTap: () {
                      // Videoya tıklayınca VideosForTeacherScreen’e yönlendirme
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => VideosForTeacherScreen(
                                videoTitle: 'P4C for Kids',
                                videoUrl: video['videoUrl']!,
                                description: video['desc']!,
                              ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200, // Kartların genişliği
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          video['thumbnail']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Daily Blog başlığı
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Daily Blog',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            // Blog kartları
            ...blogPosts.map((blog) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Blog thumbnail
                    Image.asset(
                      blog['thumbnail']!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            blog['description']!,
                            style: const TextStyle(fontSize: 14),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () => _openBlogLink(blog['link']!),
                              child: const Text('Read this blog'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
