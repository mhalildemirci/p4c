import 'package:flutter/material.dart';
import 'package:edu_p4c/widgets/bottom_nav_bar.dart';
import 'package:edu_p4c/screens/lesson_booklet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lesson {
  final String title;
  final String imagePath;
  final List<String> pdfPages; // PDF sayfa görüntüleri
  final String category; // "beginner", "intermediate", "advanced"

  Lesson({
    required this.title,
    required this.imagePath,
    required this.pdfPages,
    required this.category,
  });
}

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({Key? key}) : super(key: key);

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  String? selectedCategory;

  // Örnek ders verileri: Her dersin kategoriye göre PDF sayfa görüntüleri var
  final List<Lesson> allLessons = [
    Lesson(
      title: 'Definition of Philosophy',
      imagePath: 'assets/booklet/beginner1.jpg',
      pdfPages: [
        'assets/booklet/beginnerlevel_Page_1.jpg',
        'assets/booklet/beginnerlevel_Page_2.jpg',
        'assets/booklet/beginnerlevel_Page_3.jpg',
      ],
      category: 'beginner',
    ),
    Lesson(
      title: 'Definition of Philosophy',
      imagePath: 'assets/booklet/interminated1.jpg',
      pdfPages: [
        'assets/booklet/interminatedlevel_Page_1.jpg',
        'assets/booklet/interminatedlevel_Page_2.jpg',
        'assets/booklet/interminatedlevel_Page_3.jpg',
      ],
      category: 'intermediate',
    ),
    Lesson(
      title: 'Definition of Philosophy',
      imagePath: 'assets/booklet/advanced1.jpg',
      pdfPages: [
        'assets/booklet/advancedlevel_Page_1.jpg',
        'assets/booklet/advancedlevel_Page_2.jpg',
        'assets/booklet/advancedlevel_Page_3.jpg',
        'assets/booklet/advancedlevel_Page_4.jpg',
        'assets/booklet/advancedlevel_Page_5.jpg',
      ],
      category: 'advanced',
    ),
    // İstenirse daha fazla ders eklenebilir.
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedCategory();
  }

  Future<void> _loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Eğer kayıtlı kategori yoksa varsayılan olarak "beginner" atanır.
      selectedCategory = prefs.getString('selectedCategory') ?? 'beginner';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCategory == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final filteredLessons =
        allLessons
            .where((lesson) => lesson.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children:
              filteredLessons.map((lesson) {
                return GestureDetector(
                  onTap: () {
                    // Ders kitabı ekranına yönlendiriyoruz.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => LessonBookletScreen(
                              lessonTitle: lesson.title,
                              pdfPages: lesson.pdfPages,
                            ),
                      ),
                    );
                  },
                  child: Container(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(lesson.imagePath, width: 100, height: 100),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            lesson.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
