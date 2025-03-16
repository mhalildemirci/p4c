import 'package:flutter/material.dart';
import 'package:edu_p4c/widgets/bottom_nav_bar.dart';
import 'package:edu_p4c/screens/activity_booklet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turn_page_transition/turn_page_transition.dart';

class Activity {
  final String title;
  final String imagePath;
  final List<String> pdfPages; // Aktivite kitapçığındaki sayfa görselleri
  final String category; // Örneğin "beginner", "intermediate", "advanced"

  Activity({
    required this.title,
    required this.imagePath,
    required this.pdfPages,
    required this.category,
  });
}

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  String? selectedCategory;

  // Örnek aktivite verileri
  final List<Activity> allActivities = [
    Activity(
      title: 'Book Recommendations',
      imagePath: 'assets/activity/books/books.jpg',
      pdfPages: [
        'assets/activity/books/books_for_kids_tr_Page_01.jpg',
        'assets/activity/books/books_for_kids_tr_Page_02.jpg',
        'assets/activity/books/books_for_kids_tr_Page_03.jpg',
        'assets/activity/books/books_for_kids_tr_Page_04.jpg',
        'assets/activity/books/books_for_kids_tr_Page_05.jpg',
        'assets/activity/books/books_for_kids_tr_Page_06.jpg',
        'assets/activity/books/books_for_kids_tr_Page_07.jpg',
        'assets/activity/books/books_for_kids_tr_Page_08.jpg',
        'assets/activity/books/books_for_kids_tr_Page_09.jpg',
        'assets/activity/books/books_for_kids_tr_Page_10.jpg',
        'assets/activity/books/books_for_kids_tr_Page_11.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'My Thought Tree',
      imagePath: 'assets/activity/activity1.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_01.jpg',
        'assets/activity/activities_for_kids_Page_02.jpg',
        'assets/activity/activities_for_kids_Page_03.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'Philosophy Drawing Notebook',
      imagePath: 'assets/activity/activity2.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_04.jpg',
        'assets/activity/activities_for_kids_Page_05.jpg',
        'assets/activity/activities_for_kids_Page_06.jpg',
        'assets/activity/activities_for_kids_Page_07.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'If I Were a Philosopher for a Day',
      imagePath: 'assets/activity/activity3.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_08.jpg',
        'assets/activity/activities_for_kids_Page_09.jpg',
        'assets/activity/activities_for_kids_Page_10.jpg',
        'assets/activity/activities_for_kids_Page_11.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'Philosophical Letter Writing',
      imagePath: 'assets/activity/activity4.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_12.jpg',
        'assets/activity/activities_for_kids_Page_13.jpg',
        'assets/activity/activities_for_kids_Page_14.jpg',
        'assets/activity/activities_for_kids_Page_15.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'Philosophical Discovery of the Week\'s Concept',
      imagePath: 'assets/activity/activity5.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_16.jpg',
        'assets/activity/activities_for_kids_Page_17.jpg',
        'assets/activity/activities_for_kids_Page_18.jpg',
        'assets/activity/activities_for_kids_Page_19.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'My Imaginary Country Project',
      imagePath: 'assets/activity/activity6.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_20.jpg',
        'assets/activity/activities_for_kids_Page_21.jpg',
        'assets/activity/activities_for_kids_Page_22.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'Philosophical Dialogue Cards',
      imagePath: 'assets/activity/activity7.jpg',
      pdfPages: [
        'assets/activity/activities_for_kids_Page_23.jpg',
        'assets/activity/activities_for_kids_Page_24.jpg',
        'assets/activity/activities_for_kids_Page_25.jpg',
        'assets/activity/activities_for_kids_Page_26.jpg',
      ],
      category: 'beginner',
    ),
    Activity(
      title: 'Thought Experiments',
      imagePath: 'assets/activity/intermediate_activity1.jpeg',
      pdfPages: [
        'assets/activity/intermediate_activity_Page_01.jpg',
        'assets/activity/intermediate_activity_Page_02.jpg',
      ],
      category: 'intermediate',
    ),
    Activity(
      title: 'Animating Plato\'s Cave Allegory',
      imagePath: 'assets/activity/intermediate_activity2.jpeg',
      pdfPages: [
        'assets/activity/intermediate_activity_Page_03.jpg',
        'assets/activity/intermediate_activity_Page_04.jpg',
      ],
      category: 'intermediate',
    ),
    Activity(
      title: 'Debate on Identity and Self',
      imagePath: 'assets/activity/intermediate_activity3.jpeg',
      pdfPages: [
        'assets/activity/intermediate_activity_Page_05.jpg',
        'assets/activity/intermediate_activity_Page_06.jpg',
      ],
      category: 'intermediate',
    ),
    Activity(
      title: 'Design Your Own Utopia',
      imagePath: 'assets/activity/intermediate_activity4.jpeg',
      pdfPages: [
        'assets/activity/intermediate_activity_Page_07.jpg',
        'assets/activity/intermediate_activity_Page_08.jpg',
      ],
      category: 'intermediate',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/intermediate_activity5.jpeg',
      pdfPages: [
        'assets/activity/intermediate_activity_Page_09.jpg',
        'assets/activity/intermediate_activity_Page_10.jpg',
      ],
      category: 'intermediate',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/advanced_activity1.jpeg',
      pdfPages: [
        'assets/activity/advanced_activity_Page_1.jpg',
        'assets/activity/advanced_activity_Page_2.jpg',
      ],
      category: 'advanced',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/advanced_activity2.jpeg',
      pdfPages: ['assets/activity/advanced_activity_Page_3.jpg'],
      category: 'advanced',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/advanced_activity3.jpeg',
      pdfPages: [
        'assets/activity/advanced_activity_Page_4.jpg',
        'assets/activity/advanced_activity_Page_5.jpg',
      ],
      category: 'advanced',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/advanced_activity4.jpeg',
      pdfPages: ['assets/activity/advanced_activity_Page_6.jpg'],
      category: 'advanced',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/advanced_activity5.jpeg',
      pdfPages: [
        'assets/activity/advanced_activity_Page_7.jpg',
        'assets/activity/advanced_activity_Page_8.jpg',
      ],
      category: 'advanced',
    ),
    Activity(
      title: 'In the Footsteps of Philosophers',
      imagePath: 'assets/activity/advanced_activity6.jpeg',
      pdfPages: ['assets/activity/advanced_activity_Page_09.jpg'],
      category: 'advanced',
    ),
    // Dilerseniz daha fazla aktivite ekleyebilirsiniz...
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedCategory();
  }

  Future<void> _loadSelectedCategory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCategory = prefs.getString('selectedCategory') ?? 'beginner';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCategory == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final filteredActivities =
        allActivities
            .where((activity) => activity.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Activities')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children:
              filteredActivities.map((activity) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      TurnPageRoute(
                        builder:
                            (context) => ActivityBookletScreen(
                              activityTitle: activity.title,
                              pdfPages: activity.pdfPages,
                              currentPage: 0,
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                        overleafColor: Colors.white,
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
                        Image.asset(
                          activity.imagePath,
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            activity.title,
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
