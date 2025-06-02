import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../preferences_service.dart';
import '../util/base_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String? _username;
  int correct = 0;
  int wrong = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('currentUser');

    if (_username != null) {
      final userInfo = await PreferencesService().loadUserInfo(_username!);
      final score = await PreferencesService().loadScoreForUser(_username!);

      setState(() {
        _nameController.text = userInfo['name'] ?? '';
        _surnameController.text = userInfo['surname'] ?? '';
        _emailController.text = userInfo['email'] ?? '';
        _birthDateController.text = userInfo['birthDate'] ?? '';
        _birthPlaceController.text = userInfo['birthPlace'] ?? '';
        _cityController.text = userInfo['city'] ?? '';
        correct = score['correct']!;
        wrong = score['wrong']!;
      });
    }
  }

  Future<void> _saveUserData() async {
    if (_username == null) return;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('name_$_username', _nameController.text);
    await prefs.setString('surname_$_username', _surnameController.text);
    await prefs.setString('email_$_username', _emailController.text);
    await prefs.setString('birthDate_$_username', _birthDateController.text);
    await prefs.setString('birthPlace_$_username', _birthPlaceController.text);
    await prefs.setString('city_$_username', _cityController.text);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bilgiler güncellendi")),
      );
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
    return BasePage(
      title: "Profil Bilgileri",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _logout,
                  tooltip: 'Çıkış Yap',
                ),
              ),
              _buildTextField("Ad", _nameController),
              _buildTextField("Soyad", _surnameController),
              _buildTextField("E-posta", _emailController),
              _buildDateField("Doğum Tarihi", _birthDateController),
              _buildTextField("Doğum Yeri", _birthPlaceController),
              _buildTextField("Yaşadığı İl", _cityController),
              const SizedBox(height: 16),
              Text("Doğru Sayısı: $correct", style: _textStyle()),
              const SizedBox(height: 8),
              Text("Yanlış Sayısı: $wrong", style: _textStyle()),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveUserData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8E6C9),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFFFECB3),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) =>
        value == null || value.isEmpty ? "$label boş olamaz" : null,
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFFFECB3),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            controller.text = picked.toIso8601String().split('T')[0];
          }
        },
        validator: (value) =>
        value == null || value.isEmpty ? "$label boş olamaz" : null,
      ),
    );
  }

  TextStyle _textStyle() =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
}