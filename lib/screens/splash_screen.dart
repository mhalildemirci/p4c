import 'package:edu_p4c/screens/home_screen.dart';
import 'package:edu_p4c/screens/plato_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // SharedPreferences üzerinden kaydedilmiş e-posta ve şifre kontrolü yapıyoruz.
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail');
    final savedPassword = prefs.getString('userPassword');

    // Eğer e-posta ve şifre kayıtlı ise direkt anasayfaya yönlendir
    if (savedEmail != null && savedPassword != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // Kayıtlı giriş yoksa, splash ekranını göster ve butonla devam etsin
      setState(() {
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını alıyoruz
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Responsive ölçüler
    final double titleFontSize = screenWidth * 0.06;
    final double buttonPadding = screenWidth * 0.15;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              _isChecking
                  ? const CircularProgressIndicator()
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Splash ekranı resmi
                      Image.asset(
                        'assets/splashscreen.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Discover Yourself',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          'Orientate yourself and your thoughts with philosophical thoughts and enlighten your life.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF588BE3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: buttonPadding,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Feather',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PlatoWelcomeScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
