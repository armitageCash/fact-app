import 'package:fact_app/services/connectionsService.dart';
import 'package:fact_app/shared/repository.dart';

class ConnectionsRepository implements Repository {
  final ConnectionsService _connectionService = ConnectionsService();
  ConnectionsRepository() : super();

  getConnections<T>(String nit, String jwt) {
    return _connectionService.getConnections(nit, jwt);
  }

  getConnection<T>(String connectionId, String jwt) {
    return _connectionService.getConnection(connectionId, jwt);
  }

  /*updateConnection<T>(Connection action, String jwt) {
    return _connectionService.updateAction(action, jwt);
  }*/

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
