import 'package:flutter/material.dart';
import '../preferences_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Kullanıcıdan alınan verileri kontrol etmek için controllerlar
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Form doğrulaması için global anahtar
  final _formKey = GlobalKey<FormState>();

  // Giriş işlemini kontrol eder
  void _validateLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Kaydedilmiş kullanıcı bilgileriyle eşleşiyor mu?
    bool isValid = await PreferencesService().validateCredentials(username, password);

    if (isValid) {
      // Başarılı giriş
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Giriş başarılı!")),
      );
      Navigator.pushReplacementNamed(context, '/home'); // anasayfaya yönlendir
    } else {
      // Hatalı giriş
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hatalı kullanıcı adı veya şifre!")),
      );
    }
  }

  // Yeni bir kullanıcı hesabı oluşturur
  void _createAccount() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    await PreferencesService().saveCredentials(username, password);

    // Hesap başarıyla oluşturuldu
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Hesap oluşturuldu!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0), // pastel şeftali
      appBar: AppBar(
        title: const Text("Hoş Geldin!"),
        centerTitle: true,
        backgroundColor: const Color(0xFFBBDEFB), // pastel buz mavisi
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey, // form doğrulama için
            child: Column(
              children: [
                // Hoş bir kullanıcı ikonu
                const Icon(Icons.person_pin, size: 100, color: Color(0xFF2E7D32)),
                const SizedBox(height: 20),

                // Kullanıcı adı alanı
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFECB3), // pastel vanilya
                    labelText: "Kullanıcı Adı",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Şifre alanı
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // şifreyi gizle
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFFFECB3),
                    labelText: "Şifre",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Giriş yap butonu
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8E6C9), // pastel nane
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

                // Hesap oluştur butonu
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
}