import 'package:dio/dio.dart';
import 'package:fact_app/config/config.dart';
import 'package:flutter/widgets.dart';

class CompanyService {
  final Dio _dio = Dio(); // Crear una instancia de Dio

  Future<Map<String, dynamic>?> getCompany(int nit, String jwt) async {
    try {
      debugPrint("jwt==>" + jwt);
      // Crear el header con o sin JWT
      final headers = {
        'Content-Type': 'application/json',
      };

      // Si el JWT no es nulo ni vacío, agregarlo al header de autorización
      if (jwt.isNotEmpty) {
        headers['Authorization'] = 'Bearer $jwt';
      }

      // Hacer la petición GET
      final Response response = await _dio.get(
        '${Config.apiUrl}/api/company-data/$nit',
        options: Options(headers: headers),
      );

      // Si la respuesta es exitosa (status code 200), retorna los datos
      if (response.statusCode == 200) {
        return response.data; // Retorna la respuesta en formato JSON
      } else {
        print('Error en la autenticación: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      // Manejar errores de la petición
      print('Error en la petición: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCompanies(int userId, String jwt) async {
    try {
      debugPrint("jwt==>" + jwt);
      // Crear el header con o sin JWT
      final headers = {
        'Content-Type': 'application/json',
      };

      // Si el JWT no es nulo ni vacío, agregarlo al header de autorización
      if (jwt.isNotEmpty) {
        headers['Authorization'] = 'Bearer $jwt';
      }

      // Hacer la petición GET
      final Response response = await _dio.get(
        '${Config.apiUrl}/api/companies-data/$userId',
        options: Options(headers: headers),
      );

      // Si la respuesta es exitosa (status code 200), retorna los datos
      if (response.statusCode == 200) {
        return response.data; // Retorna la respuesta en formato JSON
      } else {
        print('Error en la autenticación: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      // Manejar errores de la petición
      print('Error en la petición: $e');
      return null;
    }
  }
}
