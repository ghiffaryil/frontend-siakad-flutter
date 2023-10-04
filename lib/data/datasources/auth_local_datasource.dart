import 'package:flutter_siakad_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  // SET KE DATA LOCAL
  Future<bool> saveAuthData(AuthResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('auth', data.toJson());
    return result;
  }

  // REMOVE DATA LOCAL
  Future<bool> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('auth');
    return result;
  }

  // GET TOKEN
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';
    if (jsonString.isEmpty) {
      return '';
    } else {
      final authModel = AuthResponseModel.fromJson(jsonString);
      return authModel.jwtToken;
    }
  }

  // IS LOGIN?
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString('auth') ?? '';
    return authJson.isNotEmpty; // Jika sedang login
  }

  // GET USER
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('auth') ?? '';

    final authModel = AuthResponseModel.fromJson(jsonString);
    return authModel.user;
  }
}
