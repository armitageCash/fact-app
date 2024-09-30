import 'package:fact_app/repository/actionsRepository.dart';
import 'package:fact_app/types/action/action.dart';
import 'package:flutter/src/widgets/framework.dart';

class Actionscontroller {
  ActionsRepository _actionsRepository = ActionsRepository();
  Actionscontroller() {}

  Future<List<ActionCompany?>> getActions(
      String nit, String jwt, BuildContext context) async {
    dynamic response = await _actionsRepository.getActions(nit, jwt);
    if (response != null) {
      return ActionCompany.fromJsonList(response['data']);
    }

    return [];
  }

  Future<ActionCompany?> getAction(
      String actionId, String jwt, BuildContext context) async {
    dynamic response = await _actionsRepository.getAction(actionId, jwt);
    if (response != null) {
      return ActionCompany.fromJson(response['data'][0]);
    }

    return null;
  }

  Future<ActionCompany?> updateAction(
      ActionCompany action, String jwt, BuildContext context) async {
    dynamic response = await _actionsRepository.updateAction(action, jwt);
    if (response != null) {
      return ActionCompany.fromJson(response['data']);
    }

    return null;
  }
}
