import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../service/categoria_service.dart';
import '../service/equipamento_service.dart';
import '../service/ticket_service.dart';
import '../service/usuario_service.dart';
import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'widgets.dart';

class TicketsAdmin extends StatefulWidget {
  const TicketsAdmin({super.key});

  static String get routeName => "${Constants.baseHrefStripped}/home";

  @override
  State<TicketsAdmin> createState() => _TicketsAdminState();
}

class _TicketsAdminState extends State<TicketsAdmin> {
  List<Map<String, dynamic>>? listaEquipamentos;
  List<Map<String, dynamic>>? listaCategorias;
  List<Map<String, dynamic>>? listaStatuses;
  List<Map<String, dynamic>>? listaUsuarios;

  List<Object?> errors = List.empty(growable: true);

  var filtro = KeyValueNotifier<String, dynamic>({});
  var dataController = ValueNotifier<DateTime?>(null);
  var dataController2 = ValueNotifier<DateTime?>(null);
  var statusController = ValueNotifier<String?>(null);
  var usuarioIdController = ValueNotifier<int?>(null);
  var categoriaIdController = ValueNotifier<int?>(null);

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
        UsuarioService().listar().then(
          (value) {
            listaUsuarios = value;
          },
          onError: (error, stackTrace) {
            showErrorDialog(context, error, stackTrace);
            listaUsuarios = null;
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
      listaUsuarios,
    ].contains(null)
        ? BaseAppWithAuthCheck(
            title: "Reservas",
            child: errors.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(errors.join(','))),
          )
        : BaseDatabaseWidget(
            title: "Reservas",
            service: TicketService(),
            filtro: filtro,
            doSearch: true,
            filtroFields: [
              {
                'field': "dt_reserva_begin",
                'label': "Data de Início",
                'controller': dataController,
                'widget': DateFormField(
                  validator: (value) {
                    var other = dataController2.value;
                    if (other != null && (value?.isAfter(other) ?? false)) {
                      return "Não pode ser depois de data final";
                    }
                    return null;
                  },
                  dataController: dataController,
                ),
                'value_converter': (value) {
                  return value != null
                      ? Constants.apiDateFormat.format(value)
                      : null;
                }
              },
              {
                'field': "dt_reserva_end",
                'label': "Data de Fim",
                'controller': dataController2,
                'widget': DateFormField(
                  validator: (value) {
                    var other = dataController.value;
                    if (other != null && (value?.isBefore(other) ?? false)) {
                      return "Não pode ser antes de data inicial";
                    }
                    return null;
                  },
                  dataController: dataController2,
                ),
                'value_converter': (value) {
                  return value != null
                      ? Constants.apiDateFormat.format(value)
                      : null;
                }
              },
              {
                'field': 'status',
                'label': "Status",
                'controller': statusController,
                'value_converter': (value) {
                  return value?.value;
                },
                'widget': FormField(
                  builder: (state) {
                    listaStatuses;
                    return DropdownMenu(
                      onSelected: (value) {},
                      expandedInsets: EdgeInsets.zero,
                      dropdownMenuEntries: [
                        const DropdownMenuEntry(
                          value: null,
                          label: "",
                        ),
                        ...?listaStatuses?.map(
                          (e) => DropdownMenuEntry<String?>(
                            value: e['codigo'],
                            label: e['descricao'],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              },
              // {
              //   'field': 'usuarioId',
              //   'label': "usuarioId",
              //   'controller': usuarioIdController,
              //   'widget': FormField(
              //     builder: (state) {
              //       listaUsuarios;
              //       return DropdownMenu(
              //         expandedInsets: EdgeInsets.zero,
              //         dropdownMenuEntries: [
              //           ...?listaUsuarios?.map(
              //             (e) => DropdownMenuEntry<int>(
              //               value: e['id'],
              //               label: e['nome'],
              //             ),
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // },
              {
                'field': 'categoriaId',
                'label': "Categoria",
                'controller': categoriaIdController,
                'value_converter': (value) {
                  return value?.value;
                },
                'widget': FormField(
                  builder: (state) {
                    listaCategorias;
                    return DropdownMenu(
                      expandedInsets: EdgeInsets.zero,
                      enableFilter: true,
                      dropdownMenuEntries: [
                        const DropdownMenuEntry(
                          value: null,
                          label: "",
                        ),
                        ...?listaCategorias?.map(
                          (e) => DropdownMenuEntry<int>(
                            value: e['id'],
                            label: e['nome'],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              },
            ],
            columns: {
              'id': {
                'title': "Num. Reserva",
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
              'dt_abertura': {
                'title': "Data de Abertura",
                'type': PlutoColumnType.text(),
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
              'usuarioNome': {
                'field': 'usuarioNome',
                'title': "Usuário",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return Center(
                    child: Text(
                      listaUsuarios!
                              .where(
                                (element) =>
                                    element['id'] ==
                                    (rendererContext
                                        .row.cells['usuarioId']?.value as int?),
                              )
                              .singleOrNull?['nome']
                              .toString() ??
                          "-",
                    ),
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

                  int? cor(String? corHex) => int.tryParse(
                        corHex?.substring(1) ?? '',
                        radix: 16,
                      );

                  return DropdownMenu<String>(
                    leadingIcon: cor(status?['corHex']) != null
                        ? Icon(
                            Icons.circle,
                            color: Color(
                              0xFF000000 + cor(status!['corHex'])!,
                            ),
                          )
                        : null,
                    inputDecorationTheme:
                        InputDecorationTheme(border: InputBorder.none),
                    initialSelection: status?['codigo'],
                    onSelected: (value) async {
                      var row = rendererContext.row.toJson();
                      try {
                        await TicketService().editarStatus(
                          row['id'],
                          value!,
                        );
                        setState(() {});
                      } on ServiceException catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertOkDialog(
                            title: Text("Erro"),
                            content: Text(e.cause),
                          ),
                        );
                      }
                    },
                    dropdownMenuEntries: listaStatuses?.map(
                          (e) {
                            return DropdownMenuEntry<String>(
                              leadingIcon: cor(e['corHex']) != null
                                  ? Icon(
                                      Icons.circle,
                                      color: Color(
                                        0xFF000000 + cor(e['corHex'])!,
                                      ),
                                    )
                                  : null,
                              value: e['codigo'],
                              label: e['descricao'],
                              labelWidget: Center(
                                child: Text(e['descricao'] ?? ''),
                              ),
                            );
                          },
                        ).toList() ??
                        [],
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
