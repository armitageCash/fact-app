import 'package:fact_app/shared/preferences/preferences.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? jwtToken;
  User? user;

  // Constructor: Inicializa cargando datos del almacenamiento local
  UserProvider() {
    _loadUserFromPreferences();
  }

  // Método para cargar el usuario y el token de SharedPreferences
  Future<void> _loadUserFromPreferences() async {
    final savedUserData = await Preferences.getUser();
    final savedToken = await Preferences.getToken();

    if (savedUserData != null) {
      user = User.fromJson(
          savedUserData); // Asegúrate que User tenga un método fromJson
    }

    if (savedToken != null) {
      jwtToken = savedToken;
    }

    notifyListeners(); // Notificar que se han cargado los datos
  }

  Future<bool> isUserLoaded() async {
    await _loadUserFromPreferences();
    return user != null;
  }

  void setUser(User? user) {
    if (user != null) {
      this.user = user; // Actualizar la propiedad de la clase
      Preferences.setUser(user!);
      notifyListeners();
    }
  }

  void setJWTToken(String token) {
    if (token.isNotEmpty) {
      jwtToken = token; // Actualizar la propiedad de la clase
      Preferences.saveToken(token);
      notifyListeners();
    }
  }

  Future<void> clearAllData() async {
    user = null;
    jwtToken = null;
    await Preferences.clearAll();
    notifyListeners();
  }
}
