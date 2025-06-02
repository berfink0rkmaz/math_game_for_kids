import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? logoUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchLogo(); // Logo çekiliyor
  }

  Future<void> fetchLogo() async {
    setState(() => isLoading = true);

    try {
      final uri = Uri.parse('https://67f44b66cbef97f40d2decaa.mockapi.io/logos');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          int randomIndex = Random().nextInt(data.length);
          setState(() {
            logoUrl = data[randomIndex]['logolink'];
          });
        }
      }
    } catch (e) {
      logoUrl = null;
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFF3E0),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFBBDEFB)),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : logoUrl != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(logoUrl!, height: 80),
              )
                  : const Text(
                "Logo yüklenemedi",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Ana Sayfa', '/home', isHome: true),
          _buildDrawerItem(Icons.add, 'Toplama Oyunu', '/addition'),
          _buildDrawerItem(Icons.remove, 'Çıkarma Oyunu', '/subtraction'),
          _buildDrawerItem(Icons.clear, 'Çarpma Oyunu', '/multiplication'),
          _buildDrawerItem(Icons.percent, 'Bölme Oyunu', '/division'),
          _buildDrawerItem(Icons.person, 'Profil', '/profile'),
          const Divider(),
          _buildDrawerItem(Icons.exit_to_app, 'Çıkış', '/login'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String label, String route,
      {bool isHome = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(label, style: const TextStyle(color: Colors.black87)),
      onTap: () {
        Navigator.pop(context); // Drawer'ı kapat
        if (isHome) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
                (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}
