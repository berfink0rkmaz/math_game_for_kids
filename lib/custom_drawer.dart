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
    fetchLogo();
  }

  Future<void> fetchLogo() async {
    setState(() => isLoading = true);
    try {
      int randomId = Random().nextInt(1000) + 1;
      final uri = Uri.parse('https://picsum.photos/id/$randomId/info');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          logoUrl = data['download_url'];
        });
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
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : logoUrl != null
                  ? Image.network(logoUrl!, height: 80)
                  : const Text("Logo yüklenemedi", style: TextStyle(color: Colors.white)),
            ),
          ),
          ListTile(
            title: const Text('Toplama Oyunu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            title: const Text('Çıkarma Oyunu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/subtraction');
            },
          ),
          ListTile(
            title: const Text('Çarpma Oyunu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/multiplication');
            },
          ),
          ListTile(
            title: const Text('Bölme Oyunu'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/division');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Çıkış'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}