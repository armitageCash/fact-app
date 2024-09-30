import 'package:fact_app/shared/preferences/preferences.dart';
import 'package:fact_app/types/company/company.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';

class CompanyProvider with ChangeNotifier {
  Company? company;

  // Constructor: Inicializa cargando datos del almacenamiento local
  CompanyProvider() {
    _loadCompanyFromPreferences();
  }

  // Método para cargar el usuario y el token de SharedPreferences
  Future<void> _loadCompanyFromPreferences() async {
    final savedCompanyData = await Preferences.getUser();
    if (savedCompanyData != null) {
      company = Company.fromJson(
          savedCompanyData); // Asegúrate que User tenga un método fromJson
    }
    notifyListeners(); // Notificar que se han cargado los datos
  }

  void setCompnay(Company? company) {
    if (company != null) {
      this.company = company; // Actualizar la propiedad de la clase
      Preferences.setCompany(company);
      notifyListeners();
    }
  }
}
