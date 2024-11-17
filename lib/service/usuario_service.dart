import 'package:shared_preferences/shared_preferences.dart';

import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'service.dart';

class UsuarioService extends IService {
  static String? _token;
  static Future<String?> get token async {
    if (_token == null) {
      var sharedPreferences = await SharedPreferences.getInstance();
      _token = sharedPreferences.getString('token');
    }
    return _token;
  }

  static List<String>? _permissions;
  static Future<List<String>?> get permissions async {
    if (_permissions == null) {
      var sharedPreferences = await SharedPreferences.getInstance();
      _permissions = sharedPreferences.getStringList('permissions');
    }
    return _permissions;
  }

  @override
  Future<Map<String, dynamic>> add(Map<String, dynamic> map) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<bool> deletar(int id) {
    // TODO: implement deletar
    throw UnimplementedError();
  }

  @override
  Future<bool> editar(int id, Map<String, dynamic> data) {
    // TODO: implement editar
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> get(int id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  // TODO: implement permissionName
  String get permissionName => throw UnimplementedError();

  @override
  Future<List<Map<String, dynamic>>> listar({
    Map<String, dynamic>? filtro,
  }) async {
    var response = await apiRequest(
      "${Constants.apiURL}/usuario",
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

  Future<bool> login({
    required String email,
    required String senha,
  }) async {
    var response = await apiRequest(
      "${Constants.apiURL}/usuario/login",
      method: 'post',
      body: {
        "email": email,
        "password": senha,
      },
      useToken: false,
    );

    Map<String, dynamic>? responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) =
        destructureResponse<Map<String, dynamic>>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var sharedPreferences = await SharedPreferences.getInstance();

    String? token = responseBody!['token'];

    if ((_token = token) != null) {
      sharedPreferences.setString(
        'token',
        token!,
      );

      List<String>? permissions = responseBody['permissions'] != null
          ? List.castFrom(responseBody['permissions'])
          : null;
      if ((_permissions = permissions) != null) {
        sharedPreferences.setStringList(
          'permissions',
          permissions!,
        );
      }
    }

    return token != null;
  }

  Future<void> logout() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove('token');
    sharedPreferences.remove('permissions');
    _token = null;
    _permissions = null;
  }
}
