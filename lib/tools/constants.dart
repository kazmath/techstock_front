import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/dashboard.dart';
import '../pages/equipamento_db.dart';
import '../pages/movimentacao_db.dart';
import '../pages/ticket_admin_db.dart';
import '../pages/ticket_usuario_db.dart';
import '../pages/usuario_db.dart';
import 'ui_web_stub.dart' // Stub implementation
    if (dart.library.html) 'dart:ui_web'; // dart:html implementation

class Constants {
  Constants._();

  static const logHttpResponse = true;
  static const logHttpRequest = true;

  static const hostURL = "http://localhost:8090";
  static const apiURL = "$hostURL/api";

  static final apiDateFormat = DateFormat("yyyy-MM-dd");

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
          'builder': ([_]) {
            return const Dashboard();
          },
          'icon': Icons.home_outlined,
          'role': 'ROLE_ADMIN',
        },
        {
          'title': "Usuarios",
          'route': Usuarios.routeName,
          'builder': ([Map<String, dynamic>? filtro]) {
            return Usuarios(initialFilter: filtro);
          },
          'icon': Icons.person_outlined,
          'role': 'ROLE_ADMIN',
        },
        {
          'title': "Reservas", // Usuário
          'route': TicketsUsuario.routeName,
          'builder': ([Map<String, dynamic>? filtro]) {
            return TicketsUsuario(initialFilter: filtro);
          },
          'icon': Icons.confirmation_num_outlined,
          'role': 'ROLE_USER',
        },
        {
          'title': "Reservas", // Usuário
          'route': TicketsAdmin.routeName,
          'builder': ([Map<String, dynamic>? filtro]) {
            return TicketsAdmin(initialFilter: filtro);
          },
          'icon': Icons.confirmation_num_outlined,
          'role': 'ROLE_ADMIN',
        },
        {
          'title': "Equipamentos",
          'route': Equipamentos.routeName,
          'builder': ([Map<String, dynamic>? filtro]) {
            return Equipamentos(initialFilter: filtro);
          },
          'icon': Icons.devices,
          'role': 'ROLE_ADMIN',
        },
        {
          'title': "Movimentações",
          'route': Movimentacoes.routeName,
          'builder': ([Map<String, dynamic>? filtro]) {
            return Movimentacoes(initialFilter: filtro);
          },
          'icon': Icons.compare_arrows,
          'role': 'ROLE_ADMIN',
        },
      ];
}
