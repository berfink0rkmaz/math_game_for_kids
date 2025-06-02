import 'package:flutter/material.dart';
import '../preferences_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _cityController = TextEditingController();

  void _validateLogin() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      bool isValid = await PreferencesService().validateCredentials(username, password);

      if (isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Giriş başarılı!")),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hatalı kullanıcı adı veya şifre!")),
        );
      }
    }
  }

  void _createAccount() async {
    if (_formKey.currentState!.validate()) {
      await PreferencesService().saveCredentials(
        username: _usernameController.text,
        password: _passwordController.text,
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        birthPlace: _birthPlaceController.text,
        birthDate: _birthDateController.text,
        city: _cityController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hesap oluşturuldu!")),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFECB3),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "$label boş olamaz";
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text("Hoş Geldin!"),
        centerTitle: true,
        backgroundColor: const Color(0xFFBBDEFB),
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.person_pin, size: 80, color: Color(0xFF2E7D32)),
                const SizedBox(height: 20),
                _buildTextField("Ad", _nameController),
                const SizedBox(height: 10),
                _buildTextField("Soyad", _surnameController),
                const SizedBox(height: 10),
                _buildTextField("E-Posta", _emailController),
                const SizedBox(height: 10),
                _buildTextField("Doğum Yeri", _birthPlaceController),
                const SizedBox(height: 10),
                _buildTextField("Doğum Tarihi", _birthDateController),
                const SizedBox(height: 10),
                _buildTextField("Yaşadığı İl", _cityController),
                const SizedBox(height: 10),
                _buildTextField("Kullanıcı Adı", _usernameController),
                const SizedBox(height: 10),
                _buildTextField("Şifre", _passwordController, obscure: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateLogin,
                  child: const Text("Giriş Yap"),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _createAccount,
                  child: const Text("Hesap Oluştur"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
