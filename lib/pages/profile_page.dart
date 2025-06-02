import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../preferences_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  int correct = 0;
  int wrong = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = PreferencesService();
    final credentials = await prefs.loadCredentials();

    if (credentials['username'] != null) {
      final scores = await prefs.loadScoreForUser(credentials['username']!);
      setState(() {
        username = credentials['username'];
        correct = scores['correct'] ?? 0;
        wrong = scores['wrong'] ?? 0;
      });
    }
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        centerTitle: true,
        backgroundColor: const Color(0xFFBBDEFB),
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: username == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👤 Kullanıcı Adı: $username", style: _textStyle()),
            const SizedBox(height: 16),
            Text("✅ Doğru Sayısı: $correct", style: _textStyle()),
            const SizedBox(height: 8),
            Text("❌ Yanlış Sayısı: $wrong", style: _textStyle()),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  }
}
