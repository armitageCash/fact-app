import 'dart:convert';
import 'package:fact_app/types/company/company.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const _tokenKey = 'jwt_token';
  static const _userKey = 'user';
  static const _companyKey = 'company';

  // Método para guardar el token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Método para recuperar el token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(_tokenKey);
    return token == 'null' || token == null ? null : token;
  }

  // Método para eliminar el token
  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Método para guardar la información del usuario
  static Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  static Future<void> setCompany(Company company) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_companyKey, jsonEncode(company));
  }

  static Future<Map<String, dynamic>?> getCompany() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_companyKey);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  // Método para recuperar la información del usuario
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Método para eliminar la información del usuario
  static Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Método para obtener un campo específico del usuario
  static Future<dynamic> getUserField(String field) async {
    final user = await getUser();
    return user?[field];
  }

  // Método para actualizar un campo específico del usuario
  static Future<void> setUserField(String field, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    final user = await getUser() ?? {};
    user[field] = value;
    await prefs.setString(_userKey, jsonEncode(user));
  }
}
