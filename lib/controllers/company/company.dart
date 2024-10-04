import 'package:fact_app/repository/companyRepository.dart';
import 'package:fact_app/types/company/company.dart';

class Companycontroller {
  CompanyRepository _companyRepository = CompanyRepository();
  Companycontroller() {}

  Future<Company?> getCompany(int nit, String jwt, context) async {
    try {
      dynamic response = await _companyRepository.getCompany(nit, jwt);
      if (response != null) {
        Company company =
            Company.fromJson(response["data"][0] as Map<String, dynamic>);
        return company;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<Company>?> getCompanies(int userId, String jwt, context) async {
    dynamic response = await _companyRepository.getCompanies(userId, jwt);
    if (response != null) {
      List<Company> company = Company.fromJsonList(response["data"]);
      return company;
    }

    return null;
  }
}
