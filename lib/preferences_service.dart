import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {

  Future<Map<String, int>> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'correct': prefs.getInt('correctCount') ?? 0,
      'wrong': prefs.getInt('wrongCount') ?? 0,
    };
  }

  Future<void> saveScore(int correct, int wrong) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('correctCount', correct);
    await prefs.setInt('wrongCount', wrong);
  }

  // Kullanıcı adı ve şifreyi kaydetme
  Future<void> saveCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  // Kullanıcı adı ve şifreyi doğrulama
  Future<bool> validateCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    String? storedPassword = prefs.getString('password');

    // Eğer kaydedilmiş bilgiler mevcutsa ve doğrulama başarılıysa true döner
    if (storedUsername != null && storedPassword != null) {
      return username == storedUsername && password == storedPassword;
    }
    return false; // Eğer bilgiler yoksa veya eşleşmiyorsa false döner
  }

  // Kullanıcı bilgilerini yükler
  Future<Map<String, String?>> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    return {'username': username, 'password': password};
  }
}
