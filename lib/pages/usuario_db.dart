// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:techstock_front/pages/usuario_dialog.dart';
import 'package:techstock_front/pages/widgets.dart';
import 'package:techstock_front/tools/utils.dart';

import '../service/setor_service.dart';
import '../service/usuario_service.dart';
import '../tools/constants.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});
  static String get routeName => "${Constants.baseHrefStripped}/usuarios";

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  List<Map<String, dynamic>>? listaSetores;

  Object? error;

  var filtro = KeyValueNotifier<String, dynamic>({});

  @override
  void initState() {
    super.initState();
    SetorService().listar().then(
      (value) {
        setState(() {
          listaSetores = value;
        });
      },
    ).onError(
      (error, stackTrace) {
        showErrorDialog(context, error, stackTrace);
        setState(() {
          listaSetores = null;
          this.error = error;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return listaSetores == null
        ? BaseAppWithAuthCheck(
            title: "Usuário",
            child: error == null
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(error!.toString())),
          )
        : BaseDatabaseWidget(
            title: "Usuário",
            service: UsuarioService(),
            filtro: filtro,
            onAdd: (controller) async {
              var result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (context) => AddEditUsuario(),
              );
              if (result != null) setState(() {});
            },
            doSearch: true,
            prefixColumnRenderer: (PlutoColumnRendererContext rendererContext) {
              return IconButton(
                onPressed: () async {
                  var result = await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (context) => AddEditUsuario(
                      editMap: rendererContext.row.toJson(),
                    ),
                  );
                  if (result != null) setState(() {});
                },
                icon: Icon(Icons.edit),
              );
            },
            prefixColumnWidth: PlutoGridSettings.rowHeight,
            columns: {
              'id': {
                'title': "Id",
                'type': PlutoColumnType.text(),
              },
              'nome': {
                'title': "Nome Completo",
                'type': PlutoColumnType.text(),
              },
              'codigo': {
                'title': "Código do Usuário",
                'type': PlutoColumnType.text(),
              },
              'email': {
                'title': "Email",
                'type': PlutoColumnType.text(),
              },
              'setorId': {
                'title': "Curso",
                'type': PlutoColumnType.text(),
                'renderer': (rendererContext) {
                  return Center(
                    child: Text(listaSetores
                        ?.where(
                          (element) =>
                              element['id'] == rendererContext.cell.value,
                        )
                        .singleOrNull?['nome']),
                  );
                }
              },
              'usuarioTipo': {
                'title': "Tipo de Usuário",
                'type': PlutoColumnType.text(),
                'renderer': (rendererContext) {
                  var value = {
                    'ADMIN': "Administrador",
                    'USER': "Usuário",
                  };
                  return Center(
                    child: Text(
                      value[rendererContext.cell.value] ?? "",
                    ),
                  );
                }
              },
            },
          );

    // return BaseApp(
    //   child: Padding(
    //     padding: const EdgeInsets.all(30.0),
    //     child:  ,
    //   ),
    // );
  }
}
