import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../service/usuario_service.dart';
import 'constants.dart';
import 'exceptions.dart';

ColorScheme getColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

String jsonify<T>(T input) {
  treatElement(element) {
    late Map Function(Map map) treatElementsMap;
    late List Function(List element) treatElementsList;

    treatElementsList = (element) {
      var result = List.from(element).map(
        (element) {
          if (element is List) {
            var list = treatElementsList(element);
            return list;
          }
          if (element is Map) {
            var map = treatElementsMap(element);
            return map;
          }

          var newValue = treatElement(element);
          return newValue;
        },
      );
      return result.toList();
    };

    treatElementsMap = (map) {
      var result = Map.from(map).map(
        (key, value) {
          if (value is List) {
            var list = treatElementsList(value);
            return MapEntry(key, list);
          }
          if (value is Map) {
            var map = treatElementsMap(value);
            return MapEntry(key, map);
          }

          var newValue = treatElement(value);
          return MapEntry(key, newValue);
        },
      );
      return result;
    };

    if (element is List) return treatElementsList(element);
    if (element is Map) return treatElementsMap(element);

    if (element is DateTime) return DateFormat("yyyy-MM-dd").format(element);

    return element;
  }

  var treatedInput = treatElement(input);
  return const JsonEncoder.withIndent("    ").convert(treatedInput);
}

Future<http.Response> apiRequest(
  String endpointUrl, {
  dynamic body,
  Map<String, String>? headers,
  String method = 'post',
  bool useToken = true,
}) async {
  headers ??= {
    'Content-Type': 'application/json',
  };

  late http.Response response;

  try {
    String? bodyString;

    if (body != null) {
      if (body is Map<String, dynamic> || body is List) {
        bodyString = jsonify(body);
      } else {
        throw ServiceException("Corpo do request inválido");
      }
    }

    if (useToken) {
      headers['Authorization'] = "Bearer ${await UsuarioService.token}";
    }

    response = switch (method.toLowerCase()) {
      'post' => await http.post(
          Uri.parse(endpointUrl),
          body: bodyString,
          headers: headers,
        ),
      'get' => await http.get(
          Uri.parse(
            // ignore: prefer_interpolation_to_compose_strings
            endpointUrl +
                (body == null
                    ? ""
                    : "?${body.entries.map(
                          (e) =>
                              "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value?.toString() ?? "")}",
                        ).join("&")}"),
          ),
          headers: headers,
        ),
      'delete' => await http.delete(
          Uri.parse(endpointUrl),
          headers: headers,
        ),
      'put' => await http.put(
          Uri.parse(endpointUrl),
          body: bodyString,
          headers: headers,
        ),
      String e => throw FormatException('Método inválido: $e.'),
    };
  } on SocketException catch (_) {
    throw ServiceException(
      "Não foi possível acessar o servidor. A internet está habilitada?",
    );
  } on http.ClientException catch (e) {
    log("==========================");
    debugPrintStack();
    throw ServiceException(e.message);
  }

  printHttpTransaction(response);

  if (response.statusCode == 403) {
    throw ApiException.message("Credenciais não autorizadas");
  }

  if (response.statusCode.toString().startsWith('5')) {
    throw ApiException.status(response.statusCode);
  }

  return response;
}

void log(Object? object) {
  if (!kDebugMode) return;
  debugPrint(object.toString());
}

void printHttpTransaction(
  http.Response response, {
  bool printRequest = Constants.logHttpRequest,
  bool printResponse = Constants.logHttpResponse,
}) {
  try {
    if (!printRequest && !printResponse) return;

    if (response.request is! http.Request) return;
    final request = response.request as http.Request;

    const httpVersion = "HTTP/1.1";

    if (printRequest || printResponse) log("###");

    if (printRequest) {
      log("$request $httpVersion");
      if (request.headers.isNotEmpty) {
        log(
          request.headers.entries
              .map(
                (e) => "${e.key}: ${e.value}",
              )
              .join("\n"),
        );
      }
      if (request.body.isNotEmpty) {
        var bodyUTF8Decoded = utf8.decode(request.bodyBytes);
        try {
          var bodyJson = jsonify(
            jsonDecode(
              bodyUTF8Decoded,
            ),
          );
          log("\n$bodyJson");
        } catch (_) {
          log(bodyUTF8Decoded);
        }
      }
    }

    if (printResponse) {
      log("\n---\n");

      log("$httpVersion ${response.statusCode}");
      if (response.headers.isNotEmpty) {
        log(
          response.headers.entries
              .map(
                (e) => "${e.key}: ${e.value}",
              )
              .join("\n"),
        );
      }
      if (response.body.isNotEmpty) {
        String responseBodyString;
        try {
          responseBodyString = jsonify(
            jsonDecode(
              utf8.decode(response.bodyBytes),
            ),
          );
        } catch (_) {
          responseBodyString = "{???}";
        }
        log("\n$responseBodyString");
      }
    }

    if (printRequest || printResponse) log("###");
  } catch (_) {}
}

(dynamic, List<String>) destructureResponse<T>(http.Response response) {
  Map<String, dynamic> responseBody;
  try {
    responseBody = jsonDecode(
      utf8.decode(response.bodyBytes),
    );
    if (!responseBody.keys.every(
      (element) => element == "data" || element == "errors",
    )) {
      throw TypeError();
    }
  } on TypeError catch (_) {
    throw ServiceException("Formato da resposta do servidor inválida.");
  }

  var data;
  if (responseBody["data"] is List) {
    var dataList = responseBody["data"];
    data = List.castFrom<dynamic, T>(dataList).toList();
  } else {
    data = responseBody["data"];
  }

  List<String> errors = List.castFrom<dynamic, String>(responseBody["errors"]);

  return (data, errors);
}
