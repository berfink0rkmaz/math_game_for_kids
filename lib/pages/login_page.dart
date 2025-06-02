import 'package:flutter/material.dart';
import '../preferences_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _validateLogin() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;

      bool isValid =
      await PreferencesService().validateCredentials(username, password);

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
      String username = _usernameController.text;
      String password = _passwordController.text;

      await PreferencesService().saveCredentials(
        username: username,
        password: password,
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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.person_pin, size: 100, color: Color(0xFF2E7D32)),
                const SizedBox(height: 20),

                _buildTextField("Kullanıcı Adı", _usernameController),
                const SizedBox(height: 12),
                _buildTextField("Şifre", _passwordController, obscure: true),
                const SizedBox(height: 12),

                _buildTextField("Ad", _nameController),
                const SizedBox(height: 12),
                _buildTextField("Soyad", _surnameController),
                const SizedBox(height: 12),
                _buildTextField("E-posta", _emailController),
                const SizedBox(height: 12),
                _buildTextField("Doğum Yeri", _birthPlaceController),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _birthDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Doğum Tarihi",
                    filled: true,
                    fillColor: const Color(0xFFFFECB3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      _birthDateController.text =
                      picked.toIso8601String().split('T')[0];
                    }
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? "Doğum tarihi boş olamaz" : null,
                ),
                const SizedBox(height: 12),

                _buildTextField("Yaşadığı İl", _cityController),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8E6C9),
                    foregroundColor: Colors.black87,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _validateLogin,
                  child: const Text("Giriş Yap"),
                ),
                const SizedBox(height: 12),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black87,
                    side: const BorderSide(color: Color(0xFF2E7D32)),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFFFECB3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) =>
      value == null || value.isEmpty ? '$label boş olamaz' : null,
    );
  }
}