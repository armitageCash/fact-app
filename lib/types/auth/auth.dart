import 'package:fact_app/types/user/user.dart';

class Auth {
  final User user; // Objeto User opcional
  final String jwt; // Token JWT opcional

  Auth({
    required this.user,
    required this.jwt,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        user: User.fromJson(json['data']['user']),
        jwt: json['data']
            ['jwt'] // Si existe 'jwt', lo asigna, de lo contrario null
        );
  }

  // Método para convertir la clase a un JSON (opcional si necesitas convertirlo de vuelta)
  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(), // Si 'user' no es null, lo convierte a JSON
      'jwt': jwt,
    };
  }
}

class AuthInput {
  String usuario;
  String password;

  AuthInput({
    required this.usuario,
    required this.password,
  });

  // Factory constructor para crear una instancia de Auth desde un JSON
  factory AuthInput.fromJson(Map<String, dynamic> json) {
    return AuthInput(
      usuario: json['Usuario'],
      password: json['Password'],
    );
  }

  // Método para convertir una instancia de Auth a JSON
  Map<String, dynamic> toJson() {
    return {
      'Usuario': usuario,
      'Password': password,
    };
  }
}
