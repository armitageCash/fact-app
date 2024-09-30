import 'package:dio/dio.dart';
import 'package:fact_app/config/config.dart';
import 'package:fact_app/types/auth/auth.dart';

class AuthService {
  final Dio _dio = Dio(); // Crear una instancia de Dio
  Future<Map<String, dynamic>?> auth(AuthInput params) async {
    final Response response = await _dio.post(
      '${Config.apiUrl}/api/login',
      data: {
        'Usuario': params.usuario,
        'Password': params.password,
      },
      options: Options(headers: {
        'Content-Type': 'application/json', // Si necesitas algún header
      }),
    );

    // Si la respuesta es exitosa (status code 200), retorna los datos
    if (response.statusCode == 200) {
      return response.data; // Retorna la respuesta en formato JSON
    } else {
      print('Error en la autenticación: ${response.statusCode}');
      return null;
    }
  }
}
