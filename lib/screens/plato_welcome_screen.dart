import 'dart:math' as math;
import 'package:edu_p4c/screens/teacher_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edu_p4c/screens/category_selection_screen.dart';

class PlatoWelcomeScreen extends StatelessWidget {
  const PlatoWelcomeScreen({Key? key}) : super(key: key);

  /// Ortak login diyaloğu, `isTeacher` parametresine göre yönlendirme yapar.
  Future<void> _showLoginDialog(BuildContext context, bool isTeacher) async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Log In'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Give up'),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                // Email + Şifre sakla
                await prefs.setString('userEmail', emailController.text);
                await prefs.setString('userPassword', passwordController.text);

                Navigator.of(ctx).pop(); // Pop-up’ı kapat

                // Eğer öğretmen ise TeacherHomeScreen'e, değilse CategorySelectionScreen'e
                if (isTeacher) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TeacherHomeScreen(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategorySelectionScreen(),
                    ),
                  );
                }
              },
              child: const Text('Log In'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Kart boyutlarını ekrana göre ayarla (en fazla 380x153 olsun)
    final double cardWidth = math.min(380, screenWidth * 0.9);
    final double cardHeight = math.min(153, screenHeight * 0.25);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Platon resmi (sağa yaslı, yukarıdan 50 px)
            Positioned(
              top: 50,
              right: 0,
              child: Image.asset(
                'assets/platonwelcome.png',
                width: screenWidth * 0.35,
              ),
            ),

            // Konuşma balonu (resmin solunda, yukarıdan 20 px)
            Positioned(
              top: 20,
              right: screenWidth * 0.35 + 10,
              child: Container(
                width: screenWidth * 0.4,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Hello, curious person\n my name is Plato.\n Let\'s find your level and get started.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // İki seçim kutusu (orta kısımda)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _optionCard(
                    context,
                    cardWidth,
                    cardHeight,
                    'assets/books_icon.png',
                    'If you are a student\nand curious about philosophy,\ncontinue with this option.',
                    isTeacher: false, // Öğrenci akışı
                  ),
                  const SizedBox(height: 20),
                  _optionCard(
                    context,
                    cardWidth,
                    cardHeight,
                    'assets/schoolteacher.png',
                    'If you are an educator\nand curious about learning new things\nfor your students, continue from here.',
                    isTeacher: true, // Öğretmen akışı
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionCard(
    BuildContext context,
    double width,
    double height,
    String imagePath,
    String text, {
    required bool isTeacher,
  }) {
    return GestureDetector(
      onTap: () {
        // Kart tıklanınca login pop-up açılır,
        // login sonrası isTeacher=true ise TeacherHomeScreen'e gider
        // aksi halde CategorySelectionScreen'e gider
        _showLoginDialog(context, isTeacher);
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
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
            const SizedBox(width: 10),
            Image.asset(
              imagePath,
              width: height * 0.5, // Yüksekliğin yarısı kadar
              height: height * 0.5,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }
}
