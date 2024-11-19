import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:techstock_front/pages/widgets.dart';
import 'package:techstock_front/service/categoria_service.dart';
import 'package:techstock_front/service/equipamento_service.dart';
import 'package:techstock_front/service/ticket_service.dart';
import 'package:techstock_front/tools/utils.dart';

import '../tools/constants.dart';

class TicketsUsuario extends StatefulWidget {
  const TicketsUsuario({super.key});

  static String get routeName => "${Constants.baseHrefStripped}/tickets";

  @override
  State<TicketsUsuario> createState() => _TicketsUsuarioState();
}

class _TicketsUsuarioState extends State<TicketsUsuario> {
  List<Map<String, dynamic>>? listaEquipamentos;
  List<Map<String, dynamic>>? listaCategorias;
  List<Map<String, dynamic>>? listaStatuses;

  List<Object?> errors = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    Future.wait(
      [
        EquipamentoService().listar().then(
          (value) {
            listaEquipamentos = value;
          },
          onError: (error, stackTrace) {
            showErrorDialog(context, error, stackTrace);
            listaEquipamentos = null;
            errors.add(error);
          },
        ),
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
      ],
    ).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return [
      listaEquipamentos,
      listaCategorias,
      listaStatuses,
    ].contains(null)
        ? BaseApp(
            title: "Reservas",
            child: errors.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(errors.join(','))),
          )
        : BaseDatabaseWidget(
            title: "Reservas",
            service: TicketService(),
            onAdd: (controller) {}, // TODO
            onSearch: (controller) {}, // TODO
            columns: {
              'id': {
                'title': "Num. Ticket",
                'type': PlutoColumnType.text(),
              },
              'equipamentoId': {
                'title': "Id Eqp.",
                'type': PlutoColumnType.text(),
              },
              'equipamentoNome': {
                'field': 'equipamentoNome',
                'title': "Nome Equipamento",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return Center(
                    child: Text(
                      listaEquipamentos!
                              .where(
                                (element) =>
                                    element['id'] ==
                                    (rendererContext.row.cells['equipamentoId']
                                        ?.value as int?),
                              )
                              .singleOrNull?['nome']
                              .toString() ??
                          "-",
                    ),
                  );
                },
              },
              'categoria': {
                'field': 'categoria',
                'title': "Categoria",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  int? categoriaId = listaEquipamentos!
                      .where(
                        (element) =>
                            element['id'] ==
                            (rendererContext.row.cells['equipamentoId']?.value
                                as int?),
                      )
                      .singleOrNull?['categoriaId'];

                  Map<String, dynamic>? categoria = listaCategorias
                      ?.where((element) => element['id'] == categoriaId)
                      .singleOrNull;

                  return Center(child: Text(categoria?['nome'] ?? "-"));
                },
              },
              'dt_reserva': {
                'title': "Data",
                'type': PlutoColumnType.text(),
              },
              'observacao': {
                'title': "Observação",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return SingleChildScrollView(
                    child: Text(rendererContext.cell.value ?? ''),
                  );
                },
              },
              'status': {
                'title': "Status",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  listaStatuses;
                  Map<String, dynamic>? status = listaStatuses!
                      .where(
                        (element) =>
                            element['codigo'] ==
                            rendererContext.cell.value as String?,
                      )
                      .singleOrNull;

                  int? cor = int.tryParse(
                    (status?['corHex'] as String?)?.substring(1) ?? '',
                    radix: 16,
                  );
                  return Center(
                    child: Text.rich(TextSpan(
                      children: [
                        if (cor != null)
                          WidgetSpan(
                            child: Icon(
                              Icons.circle,
                              color: Color(0xFF000000 + cor),
                            ),
                          ),
                        TextSpan(text: status?['descricao'] ?? ''),
                      ],
                    )),
                  );
                },
              },

              // 'codigo': {
              //   'title': "Código do Usuário",
              //   'type': PlutoColumnType.text(),
              // },
              // 'email': {
              //   'title': "Email",
              //   'type': PlutoColumnType.text(),
              // },
              // 'setorId': {
              //   'title': "Setor",
              //   'type': PlutoColumnType.text(),
              //   'renderer': (rendererContext) {
              //     return Center(
              //       child: Text(listaSetores
              //           ?.where(
              //             (element) =>
              //                 element['id'] == rendererContext.cell.value,
              //           )
              //           .singleOrNull?['nome']),
              //     );
              //   }
              // },
              // 'usuarioTipo': {
              //   'title': "Tipo de Usuário",
              //   'type': PlutoColumnType.text(),
              //   'renderer': (rendererContext) {
              //     var value = {
              //       'ADMIN': "Administrador",
              //       'USER': "Usuário",
              //     };
              //     return Center(
              //       child: Text(
              //         value[rendererContext.cell.value] ?? "",
              //       ),
              //     );
              //   }
              // },
            },
          );
  }
}
