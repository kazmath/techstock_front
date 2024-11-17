abstract class IService {
  String get permissionName;
  Future<List<Map<String, dynamic>>> listar({Map<String, dynamic>? filtro});
  Future<Map<String, dynamic>> get(int id);
  Future<bool> editar(int id, Map<String, dynamic> data);
  Future<bool> deletar(int id);
  Future<Map<String, dynamic>> add(Map<String, dynamic> map);
}
