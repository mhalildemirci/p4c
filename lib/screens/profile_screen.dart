import 'package:edu_p4c/screens/plato_welcome_screen.dart';
import 'package:edu_p4c/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail') ?? 'No Email';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profil resmi
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    userEmail != null
                        ? NetworkImage(_generateAvatarUrl(userEmail!))
                        : null,
                child:
                    userEmail == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
              ),
              const SizedBox(height: 16),
              const Text(
                'Junior',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Level 1: Basic Lessons'),
              const SizedBox(height: 16),
              Text('Registered email: $userEmail'),
              const SizedBox(height: 16),
              // Çıkış yap
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear(); // Tüm verileri temizle
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlatoWelcomeScreen(),
                    ),
                  );
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generateAvatarUrl(String email) {
    // Örnek olarak dicebear
    return 'https://api.dicebear.com/6.x/adventurer/png?seed=$email';
  }
}
