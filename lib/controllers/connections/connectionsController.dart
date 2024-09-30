import 'package:fact_app/repository/connectionsRepository.dart';
import 'package:fact_app/types/connection/connection.dart';
import 'package:flutter/src/widgets/framework.dart';

class Connectionscontroller {
  ConnectionsRepository _connectionsRepository = ConnectionsRepository();
  Connectionscontroller() {}

  Future<List<Connection?>> getConnections(
      String nit, String jwt, BuildContext context) async {
    dynamic response = await _connectionsRepository.getConnections(nit, jwt);
    if (response != null) {
      return Connection.fromJsonList(response['data']);
    }

    return [];
  }

  Future<Connection?> getConnection(
      String connectionId, String jwt, BuildContext context) async {
    dynamic response =
        await _connectionsRepository.getConnection(connectionId, jwt);
    if (response != null) {
      return Connection.fromJson(response['data'][0]);
    }

    return null;
  }

  /*Future<Connection?> updateAction(
      ActionCompany action, String jwt, BuildContext context) async {
    dynamic response = await _actionsRepository.updateAction(action, jwt);
    if (response != null) {
      return Connection.fromJson(response['data']);
    }

    return null;
  }*/
}
