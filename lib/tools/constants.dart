import 'package:flutter/material.dart';
import 'package:techstock_front/pages/dashboard.dart';
import 'package:techstock_front/pages/tickets_usuario_db.dart';
import 'package:techstock_front/pages/usuarios_db.dart';

import 'ui_web_stub.dart' // Stub implementation
    if (dart.library.html) 'dart:ui_web'; // dart:html implementation

class Constants {
  Constants._();

  static const logHttpResponse = true;
  static const logHttpRequest = true;

  static const hostURL = "http://localhost:8090";
  static const apiURL = "$hostURL/api";

  static String get baseHref {
    var path = const BrowserPlatformLocation().getBaseHref() != null
        ? Uri.parse(const BrowserPlatformLocation().getBaseHref()!).path
        : '';
    path = path.replaceFirst(RegExp(r'/$'), '');
    return '$path/';
  }

  static String get baseHrefStripped =>
      baseHref.replaceFirst(RegExp(r'/$'), '');

  static List<Map<String, dynamic>> get telas => [
        {
          'title': "Dashboard",
          'route': Dashboard.routeName,
          'widget': const Dashboard(),
          'icon': Icons.home_outlined,
          'role': 'ROLE_ADMIN',
        },
        {
          'title': "Usuarios",
          'route': Usuarios.routeName,
          'widget': const Usuarios(),
          'icon': Icons.person_outlined,
          'role': 'ROLE_ADMIN',
        },
        {
          'title': "Reservas", // Usuário
          'route': TicketsUsuario.routeName,
          'widget': const TicketsUsuario(),
          'icon': Icons.confirmation_num_outlined,
          'role': 'ROLE_USER',
        },
      ];
}
