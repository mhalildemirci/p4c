import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_p4c/screens/home_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({Key? key}) : super(key: key);

  Future<void> _saveCategoryAndNavigate(
    String category,
    BuildContext context,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCategory', category);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 146 x 227 boyutlarına sığdır
    final double boxWidth = math.min(146, screenWidth * 0.4);
    final double boxHeight = math.min(227, screenHeight * 0.4);

    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Seçimi')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // İlk satırda Beginner ve Intermediate yan yana
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _categoryBox(
                  context,
                  boxWidth,
                  boxHeight,
                  'assets/littleboy.png',
                  'Beginner',
                  'beginner',
                ),
                _categoryBox(
                  context,
                  boxWidth,
                  boxHeight,
                  'assets/youngboy.png',
                  'Intermediate',
                  'intermediate',
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Altta ortada Advanced
            _categoryBox(
              context,
              boxWidth,
              boxHeight,
              'assets/woman.png',
              'Advanced',
              'advanced',
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryBox(
    BuildContext context,
    double width,
    double height,
    String imagePath,
    String label,
    String category,
  ) {
    return GestureDetector(
      onTap: () => _saveCategoryAndNavigate(category, context),
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(8),
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
            Image.asset(imagePath, width: width * 0.8, height: height * 0.5),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
