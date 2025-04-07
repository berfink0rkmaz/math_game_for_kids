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
  // Rastgele alınacak logo URL'si
  String? logoUrl;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchLogo(); // Drawer açıldığında logo yükle
  }

  // İnternetten rastgele logo çek
  Future<void> fetchLogo() async {
    setState(() => isLoading = true);

    try {
      final uri = Uri.parse('https://67f44b66cbef97f40d2decaa.mockapi.io/logos');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          int randomIndex = Random().nextInt(data.length); // 0 - veri uzunluğu arasında
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
      backgroundColor: const Color(0xFFFFF3E0), // pastel şeftali

      child: Column(
        children: [
          // Logo bölümü
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

          // Menü seçenekleri
          _buildListTile(
            icon: Icons.home,
            label: 'Ana Sayfa',
            route: '/home',
            isHome: true, // özel yönlendirme için
          ),
          _buildListTile(
            icon: Icons.add,
            label: 'Toplama Oyunu',
            route: '/addition',
          ),
          _buildListTile(
            icon: Icons.remove,
            label: 'Çıkarma Oyunu',
            route: '/subtraction',
          ),
          _buildListTile(
            icon: Icons.clear,
            label: 'Çarpma Oyunu',
            route: '/multiplication',
          ),
          _buildListTile(
            icon: Icons.percent,
            label: 'Bölme Oyunu',
            route: '/division',
          ),

          const Divider(),

          _buildListTile(
            icon: Icons.exit_to_app,
            label: 'Çıkış',
            route: '/login',
          ),
        ],
      ),
    );
  }

  // Drawer için her bir buton
  Widget _buildListTile({
    required IconData icon,
    required String label,
    required String route,
    bool isHome = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(label, style: const TextStyle(color: Colors.black87)),
      onTap: () {
        Navigator.pop(context); // Drawer'ı kapat
        if (isHome) {
          // Ana sayfa: önceki sayfaları temizle
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
                (Route<dynamic> route) => false,
          );
        } else {
          // Diğer sayfalar
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}