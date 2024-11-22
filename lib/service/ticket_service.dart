import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'service.dart';

class TicketService extends IService {
  @override
  Future<int> add(Map<String, dynamic> map) async {
    var response = await apiRequest(
      "${Constants.apiURL}/ticket",
      body: map,
    );

    int? responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) =
        destructureResponse<Map<String, dynamic>>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var items = responseBody;

    return items!;
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

  Future<int?> editarStatus(int id, String data) async {
    var response = await apiRequest(
      "${Constants.apiURL}/ticket/editar_status/$id",
      method: 'put',
      body: data,
    );

    int? responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) = destructureResponse<int>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var item = responseBody;

    return item;
  }

  @override
  Future<Map<String, dynamic>> get(int id) async {
    var response = await apiRequest(
      "${Constants.apiURL}/ticket/$id",
      method: 'get',
    );

    Map<String, dynamic> responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) =
        destructureResponse<Map<String, dynamic>>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var item = responseBody;

    return item;
  }

  @override
  Future<List<Map<String, dynamic>>> listar({
    Map<String, dynamic>? filtro,
  }) async {
    var response = await apiRequest(
      "${Constants.apiURL}/ticket",
      method: 'get',
      body: filtro,
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

  Future<List<Map<String, dynamic>>> listarStatuses() async {
    var response = await apiRequest(
      "${Constants.apiURL}/ticket/statuses",
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
