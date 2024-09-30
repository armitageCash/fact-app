abstract class Repository {
  Future find<T>(String query, token) async {
    return T;
  }

  findOne<T>(int id, String population, String token, String query) {
    return T;
  }

  createOne<T>(T data, String token) {
    return T;
  }

  update<T>(int id, T data, String token, String query) {
    return T;
  }

  updateMany<T>(T data, String token, String query) {
    return T;
  }
}
