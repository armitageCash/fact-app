import 'package:fact_app/services/authService.dart';
import 'package:fact_app/shared/repository.dart';
import 'package:fact_app/types/auth/auth.dart';

class AuthhRepository implements Repository {
  final AuthService _authService = AuthService();
  AuthhRepository() : super();

  auth<T>(AuthInput params) {
    return _authService.auth(params);
  }

  @override
  findOne<T>(int id, String population, String token, String query) {
    throw UnimplementedError();
  }

  @override
  Future find<T>(String query, token) async {
    return [];
  }

  @override
  createOne<T>(T data, String token) {
    // TODO: implement createOne
    throw UnimplementedError();
  }

  @override
  update<T>(int id, T data, String token, String query) {
    // TODO: implement updateOne
    throw UnimplementedError();
  }

  @override
  updateMany<T>(T data, String token, String query) {
    // TODO: implement updateMany
    throw UnimplementedError();
  }
}
