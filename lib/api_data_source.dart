import 'baseNetwork.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadGames() {
    return BaseNetwork.get("games");
  }
  Future<Map<String, dynamic>> loadDetailUser(int idDiterima){
    String id = idDiterima.toString();
    return BaseNetwork.get("users/$id");
  }
}
