import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/base_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController birthDateController;
  late TextEditingController birthPlaceController;
  late TextEditingController cityController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  int correct = 0;
  int wrong = 0;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    birthDateController = TextEditingController();
    birthPlaceController = TextEditingController();
    cityController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      fullNameController.text = prefs.getString('fullName') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      birthDateController.text = prefs.getString('birthDate') ?? '';
      birthPlaceController.text = prefs.getString('birthPlace') ?? '';
      cityController.text = prefs.getString('city') ?? '';
      usernameController.text = prefs.getString('username') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      correct = prefs.getInt('${usernameController.text}_correct') ?? 0;
      wrong = prefs.getInt('${usernameController.text}_wrong') ?? 0;
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('fullName', fullNameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('birthDate', birthDateController.text);
    await prefs.setString('birthPlace', birthPlaceController.text);
    await prefs.setString('city', cityController.text);
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);

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
              _buildTextField("Ad Soyad", fullNameController),
              _buildTextField("E-posta", emailController),
              _buildTextField("Doğum Tarihi", birthDateController),
              _buildTextField("Doğum Yeri", birthPlaceController),
              _buildTextField("Yaşadığı İl", cityController),
              _buildTextField("Kullanıcı Adı", usernameController),
              _buildTextField("Şifre", passwordController, obscure: true),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool obscure = false}) {
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
        validator: (value) {
          if (value == null || value.isEmpty) return "$label boş olamaz";
          return null;
        },
      ),
    );
  }

  TextStyle _textStyle() => const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
}
