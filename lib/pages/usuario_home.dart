import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../service/setor_service.dart';
import '../service/usuario_service.dart';
import '../tools/constants.dart';
import '../tools/exceptions.dart';
import 'widgets.dart';

class UsuarioHome extends StatefulWidget {
  const UsuarioHome({super.key});
  static String get routeName => "${Constants.baseHrefStripped}/home";

  @override
  State<UsuarioHome> createState() => _UsuarioHomeState();
}

class _UsuarioHomeState extends State<UsuarioHome> {
  List<Map<String, dynamic>>? listaSetores;

  Object? error;

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
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (error is ServiceException) {
            showDialog(
              context: context,
              builder: (context) => AlertOkDialog(
                title: Text("Erro"),
                content: Text(error.cause),
              ),
            );
            return;
          }
          showDialog(
            context: context,
            builder: (context) => UnknownErrorDialog(
              exception: error ?? Null,
              stacktrace: stackTrace,
            ),
          );
        });
        setState(() {
          listaSetores = null;
          this.error = error;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseApp(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: listaSetores == null
            ? error == null
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(error!.toString()))
            : BaseDatabaseWidget(
                title: "Usuário",
                service: UsuarioService(),
                prefixColumnRenderer: (rendererContext) {
                  return IconButton(
                    onPressed: () {},
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
                    'field': 'codigo',
                    'type': PlutoColumnType.text(),
                  },
                  'email': {
                    'title': "Email",
                    'type': PlutoColumnType.text(),
                  },
                  'setorId': {
                    'title': "Setor",
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
              ),
      ),
    );
  }
}
