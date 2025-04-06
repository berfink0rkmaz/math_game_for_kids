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

  // Kullanıcı adı ve şifre doğrulama
  void _validateLogin() async {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    // SharedPreferences'ten kullanıcı adı ve şifreyi kontrol et
    bool isValid = await PreferencesService().validateCredentials(enteredUsername, enteredPassword);

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Giriş başarılı!")));
      // Giriş başarılı ise anasayfaya yönlendirebilirsiniz
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hatalı kullanıcı adı veya şifre!")));
    }
  }

  // Hesap oluşturma
  void _createAccount() async {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    // Kullanıcı adı ve şifreyi kaydet
    await PreferencesService().saveCredentials(enteredUsername, enteredPassword);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hesap oluşturuldu!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Sayfası")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Kullanıcı Adı"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true, // Şifreyi gizler
              decoration: InputDecoration(labelText: "Şifre"),
            ),
            // Giriş yap butonu
            ElevatedButton(
              onPressed: _validateLogin,
              child: Text("Giriş Yap"),
            ),
            // Hesap oluştur butonu
            ElevatedButton(
              onPressed: _createAccount,
              child: Text("Hesap Oluştur"),
            ),
          ],
        ),
      ),
    );
  }
}
