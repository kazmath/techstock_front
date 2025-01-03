import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'service.dart';

class MovimentacaoService extends IService {
  @override
  Future<int> add(Map<String, dynamic> map) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> deletar(int id) {
    // TODO: implement deletar
    throw UnimplementedError();
  }

  @override
  Future<int> editar(int id, Map<String, dynamic> data) {
    // TODO: implement editar
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>?> listar({
    Map<String, dynamic>? filtro,
  }) async {
    var response = await apiRequest(
      "${Constants.apiURL}/movimentacao",
      method: 'get',
      body: filtro,
    );

    List<Map<String, dynamic>>? responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) =
        destructureResponse<Map<String, dynamic>>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var items = responseBody;

    return items;
  }

  Future<List<Map<String, dynamic>>?> listarTipos() async {
    var response = await apiRequest(
      "${Constants.apiURL}/movimentacao/tipos",
      method: 'get',
    );

    List<Map<String, dynamic>> responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) =
        destructureResponse<Map<String, dynamic>>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var items = responseBody;

    return items;
  }

  @override
  // TODO: implement permissionName
  String get permissionName => throw UnimplementedError();
}
