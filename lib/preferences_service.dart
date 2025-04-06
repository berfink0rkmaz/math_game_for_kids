import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Kullanıcı adı ve şifreyi kaydetme (kullanıcıya özel saklama)
  Future<void> saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Kullanıcıyı kullanıcı listesine ekle
    List<String> users = prefs.getStringList('users') ?? [];
    if (!users.contains(username)) {
      users.add(username);
      await prefs.setStringList('users', users);
    }

    // Şifreyi kullanıcıya özel sakla
    await prefs.setString('password_$username', password);

    // O anki kullanıcıyı sakla
    await prefs.setString('currentUser', username);
  }

  // Giriş yapan kullanıcıyı doğrulama
  Future<bool> validateCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString('password_$username');

    if (storedPassword != null && storedPassword == password) {
      await prefs.setString('currentUser', username);
      return true;
    }
    return false;
  }

  // Şu an giriş yapmış kullanıcı bilgilerini yükle
  Future<Map<String, String?>> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('currentUser');
    String? password = prefs.getString('password_$username');

    return {
      'username': username,
      'password': password,
    };
  }

  // Kullanıcıya özel doğru/yanlış skorunu kaydet
  Future<void> saveScoreForUser(String username, int correct, int wrong) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('correctCount_$username', correct);
    await prefs.setInt('wrongCount_$username', wrong);
  }

  // Kullanıcıya özel doğru/yanlış skorunu yükle
  Future<Map<String, int>> loadScoreForUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'correct': prefs.getInt('correctCount_$username') ?? 0,
      'wrong': prefs.getInt('wrongCount_$username') ?? 0,
    };
  }
}