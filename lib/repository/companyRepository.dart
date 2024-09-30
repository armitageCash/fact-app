import 'package:fact_app/services/companyService.dart';
import 'package:fact_app/shared/repository.dart';
import 'package:flutter/widgets.dart';

class CompanyRepository implements Repository {
  final CompanyService _companyService = CompanyService();
  CompanyRepository() : super();

  getCompany<T>(int nit, String jwt) {
    return _companyService.getCompany(nit, jwt);
  }

  getCompanies<T>(int userId, String jwt) {
    return _companyService.getCompanies(userId, jwt);
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
