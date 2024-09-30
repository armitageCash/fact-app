import 'package:dio/dio.dart';
import 'package:fact_app/components/modal/modal.dart';
import 'package:fact_app/repository/authRepository.dart';
import 'package:fact_app/types/auth/auth.dart';
import 'package:flutter/widgets.dart';

class AuthController {
  AuthhRepository _authhRepository = AuthhRepository();
  AuthController() {}

  Future<Auth?> login(AuthInput params, BuildContext context) async {
    try {
      dynamic result = await _authhRepository.auth(params);
      if (result != null) {
        Auth auth = Auth.fromJson(result as Map<String, dynamic>);
        return auth;
      }
    } catch (e) {
      DioException error = e as DioException;
      Modal.showModal(
          context: context,
          onOk: () {},
          onCancel: () {},
          OkText: 'Ok',
          content: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                child: Text(error.response!.statusCode == 500
                    ? "Ocurrio un error al procesar la solicitud intente mas tarde."
                    : "Usuario o Contraseña incorrectos"),
              )
            ],
          ),
          title: 'Error en la solicitud',
          Canceltext: 'Cancelar');
    }

    return null;
  }
}
