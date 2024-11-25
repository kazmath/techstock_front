import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../service/categoria_service.dart';
import '../service/equipamento_service.dart';
import '../service/movimentacao_service.dart';
import '../service/ticket_service.dart';
import '../service/usuario_service.dart';
import '../tools/constants.dart';
import '../tools/utils.dart';
import 'widgets.dart';

class Movimentacoes extends StatefulWidget {
  const Movimentacoes({super.key});

  static String get routeName => "${Constants.baseHrefStripped}/movimentacao";

  @override
  State<Movimentacoes> createState() => _MovimentacoesState();
}

class _MovimentacoesState extends State<Movimentacoes> {
  List<Map<String, dynamic>>? listaStatuses;
  List<Map<String, dynamic>>? listaCategorias;
  List<Map<String, dynamic>>? listaTiposMov;

  Map<int, dynamic> listaEquipamentosCache = {};
  Map<int, dynamic> listaTicketsCache = {};
  Map<int, dynamic> listaUsuariosCache = {};

  List<Object?> errors = List.empty(growable: true);

  var filtro = KeyValueNotifier<String, dynamic>({});

  @override
  void initState() {
    super.initState();
    Future.wait(
      [
        // EquipamentoService().listar().then(
        //   (value) {
        //     listaEquipamentos = value;
        //   },
        //   onError: (error, stackTrace) {
        //     showErrorDialog(context, error, stackTrace);
        //     listaEquipamentos = null;
        //     errors.add(error);
        //   },
        // ),
        CategoriaService().listar().then(
          (value) {
            listaCategorias = value;
          },
          onError: (error, stackTrace) {
            showErrorDialog(context, error, stackTrace);
            listaCategorias = null;
            errors.add(error);
          },
        ),
        TicketService().listarStatuses().then(
          (value) {
            listaStatuses = value;
          },
          onError: (error, stackTrace) {
            showErrorDialog(context, error, stackTrace);
            listaStatuses = null;
            errors.add(error);
          },
        ),
        MovimentacaoService().listarTipos().then(
          (value) {
            listaTiposMov = value;
          },
          onError: (error, stackTrace) {
            showErrorDialog(context, error, stackTrace);
            listaTiposMov = null;
            errors.add(error);
          },
        ),
      ],
    ).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return [
      // listaEquipamentos,
      listaCategorias,
      listaStatuses,
    ].contains(null)
        ? BaseAppWithAuthCheck(
            title: "Movimentações",
            child: errors.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(errors.join(','))),
          )
        : BaseDatabaseWidget(
            title: "Movimentações",
            service: MovimentacaoService(),
            filtro: filtro,
            doSearch: true,
            columns: {
              'id': {
                'title': "Id",
                'type': PlutoColumnType.text(),
              },
              'categoriaId': {
                'field': 'categoriaId',
                'title': "Categoria",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return FutureBuilder(
                    future: getEquipamentoObj(
                      rendererContext.row.cells['id']?.value,
                    ),
                    builder: (context, snapshot) {
                      int? categoriaId = snapshot.data?['categoriaId'];

                      Map<String, dynamic>? categoria = listaCategorias
                          ?.where((element) => element['id'] == categoriaId)
                          .singleOrNull;

                      return Center(child: Text(categoria?['nome'] ?? "-"));
                    },
                  );
                },
              },
              'descricao': {
                'field': 'descricao',
                'title': "Especificação do Equipamento",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return FutureBuilder(
                    future: getEquipamentoObj(
                      rendererContext.row.cells['id']?.value,
                    ),
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(snapshot.data?['descricao'] ?? ""),
                      );
                    },
                  );
                },
              },
              'observacao': {
                'field': 'observacao',
                'title': "Observação",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return FutureBuilder(
                    future: getTicketObj(
                      rendererContext.row.cells['ticketId']?.value,
                    ),
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(snapshot.data?['observacao'] ?? ""),
                      );
                    },
                  );
                },
              },
              'data': {
                'title': "Data/Hora",
                'type': PlutoColumnType.text(),
              },
              'usuarioId': {
                'title': "Solicitante",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return FutureBuilder(
                    future: getUsuarioObj(
                      rendererContext.row.cells['usuarioId']?.value,
                    ),
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(snapshot.data?['nome'] ?? ""),
                      );
                    },
                  );
                },
              },
              'usuarioAdmId': {
                'title': "Tratativa",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return FutureBuilder(
                    future: getUsuarioObj(
                      rendererContext.row.cells['usuarioAdmId']?.value,
                    ),
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(snapshot.data?['nome'] ?? ""),
                      );
                    },
                  );
                },
              },
              'tipo': {
                'title': "Tipo de Movimentação",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  Map<String, dynamic>? tipo = listaTiposMov!
                      .where(
                        (element) =>
                            element['codigo'] ==
                            rendererContext.cell.value as String?,
                      )
                      .singleOrNull;

                  return Center(child: Text(tipo?['descricao'] ?? ''));
                },
              }
            },
          );
  }

  Future<Map<String, dynamic>?> getEquipamentoObj(int? id) async {
    if (id == null) return null;

    if (listaEquipamentosCache.keys.contains(id)) {
      return listaEquipamentosCache[id];
    }

    return await EquipamentoService().get(id);
  }

  Future<Map<String, dynamic>?> getTicketObj(int? id) async {
    if (id == null) return null;

    if (listaTicketsCache.keys.contains(id)) {
      return listaTicketsCache[id];
    }

    return await TicketService().get(id);
  }

  Future<Map<String, dynamic>?> getUsuarioObj(int? id) async {
    if (id == null) return null;

    if (listaUsuariosCache.keys.contains(id)) {
      return listaUsuariosCache[id];
    }

    return await UsuarioService().get(id);
  }
}
