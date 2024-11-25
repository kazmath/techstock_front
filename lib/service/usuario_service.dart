import 'package:shared_preferences/shared_preferences.dart';

import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'service.dart';

class UsuarioDTO {
  UsuarioDTO({
    required this.nome,
    required this.token,
    required this.codigo,
    required this.email,
    required this.permissions,
  });

  final String? nome;
  final String token;
  final String? codigo;
  final String? email;
  final List<String>? permissions;

  @override
  operator ==(other) {
    return other is UsuarioDTO && other.codigo == codigo;
  }

  @override
  int get hashCode => codigo.hashCode;
}

class UsuarioService extends IService {
  static UsuarioDTO? _usuario;
  static Future<UsuarioDTO?> get usuario async {
    if (_usuario == null) {
      var sharedPreferences = await SharedPreferences.getInstance();

      var token = sharedPreferences.getString('token');
      if (token == null) return null;

      _usuario = UsuarioDTO(
        nome: sharedPreferences.getString('nome'),
        token: token,
        codigo: sharedPreferences.getString('codigo'),
        email: sharedPreferences.getString('email'),
        permissions: sharedPreferences.getStringList('permissions'),
      );
    }
    return _usuario;
  }

  static Future<bool> checkAuth() async {
    var token = await UsuarioService._usuario?.token;
    var permissions = await UsuarioService._usuario?.permissions;

    if (token == null || permissions == null) {
      await UsuarioService().logout();
      return false;
    }

    try {
      await apiRequest(
        "${Constants.apiURL}/ticket",
      );
      return true;
    } on ServiceException catch (_) {
      await UsuarioService().logout();
      return false;
    }
  }

  @override
  Future<int> add(Map<String, dynamic> map) async {
    var response = await apiRequest(
      "${Constants.apiURL}/usuario",
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
  Future<bool> deletar(int id) async {
    var response = await apiRequest(
      "${Constants.apiURL}/usuario/$id",
      method: 'delete',
    );

    bool responseBody;
    List<String> responseErrors;

    (responseBody, responseErrors) = destructureResponse<bool>(response);

    if (responseErrors.isNotEmpty) {
      throw ServiceException(responseErrors.join(","));
    }

    var item = responseBody;

    return item;
  }

  @override
  Future<int> editar(int id, Map<String, dynamic> data) async {
    var response = await apiRequest(
      "${Constants.apiURL}/usuario/$id",
      method: 'put',
      body: data,
    );

    int responseBody;
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
      "${Constants.apiURL}/usuario/$id",
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

    // var usuario = _usuario;

    if (token != null) {
      sharedPreferences.setString('token', token);

      String? email = responseBody['email'];
      if (email == null) return false;
      sharedPreferences.setString('email', email);

      String? nome = responseBody['nome'];
      if (nome == null) return false;
      sharedPreferences.setString('nome', nome);

      String? codigo = responseBody['codigo'];
      if (codigo == null) return false;
      sharedPreferences.setString('codigo', codigo);

      List<String>? permissions = responseBody['permissions'] != null
          ? List.castFrom(responseBody['permissions'])
          : null;
      if (permissions == null) return false;
      sharedPreferences.setStringList('permissions', permissions);
    }

    return (await usuario) != null;
  }

  Future<void> logout() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.remove('token');
    sharedPreferences.remove('email');
    sharedPreferences.remove('codigo');
    sharedPreferences.remove('permissions');

    _usuario = null;
  }
}
