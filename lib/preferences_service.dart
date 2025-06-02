import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Kullanıcı adı ve şifreyi kaydetme + ekstra bilgiler
  Future<void> saveCredentials({
    required String username,
    required String password,
    required String name,
    required String surname,
    required String email,
    required String birthPlace,
    required String birthDate,
    required String city,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> users = prefs.getStringList('users') ?? [];
    if (!users.contains(username)) {
      users.add(username);
      await prefs.setStringList('users', users);
    }

    await prefs.setString('password_$username', password);
    await prefs.setString('name_$username', name);
    await prefs.setString('surname_$username', surname);
    await prefs.setString('email_$username', email);
    await prefs.setString('birthPlace_$username', birthPlace);
    await prefs.setString('birthDate_$username', birthDate);
    await prefs.setString('city_$username', city);
    await prefs.setString('currentUser', username);
  }

  Future<bool> validateCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedPassword = prefs.getString('password_$username');

    if (storedPassword != null && storedPassword == password) {
      await prefs.setString('currentUser', username);
      return true;
    }
    return false;
  }

  Future<Map<String, String?>> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('currentUser');
    String? password = prefs.getString('password_$username');

    return {
      'username': username,
      'password': password,
    };
  }

  Future<Map<String, String>> loadUserInfo(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name_$username') ?? '',
      'surname': prefs.getString('surname_$username') ?? '',
      'email': prefs.getString('email_$username') ?? '',
      'birthPlace': prefs.getString('birthPlace_$username') ?? '',
      'birthDate': prefs.getString('birthDate_$username') ?? '',
      'city': prefs.getString('city_$username') ?? '',
    };
  }

  Future<void> saveScoreForUser(String username, int correct, int wrong) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('correctCount_$username', correct);
    await prefs.setInt('wrongCount_$username', wrong);
  }

  Future<Map<String, int>> loadScoreForUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'correct': prefs.getInt('correctCount_$username') ?? 0,
      'wrong': prefs.getInt('wrongCount_$username') ?? 0,
    };
  }
}