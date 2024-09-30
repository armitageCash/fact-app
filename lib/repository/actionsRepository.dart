import 'package:fact_app/services/actionService.dart';
import 'package:fact_app/shared/repository.dart';
import 'package:fact_app/types/action/action.dart';

class ActionsRepository implements Repository {
  final ActionService _actionsService = ActionService();
  ActionsRepository() : super();

  getActions<T>(String nit, String jwt) {
    return _actionsService.getActions(nit, jwt);
  }

  getAction<T>(String actionId, String jwt) {
    return _actionsService.getAction(actionId, jwt);
  }

  updateAction<T>(ActionCompany action, String jwt) {
    return _actionsService.updateAction(action, jwt);
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
