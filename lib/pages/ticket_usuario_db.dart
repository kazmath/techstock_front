import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:techstock_front/service/usuario_service.dart';

import '../service/categoria_service.dart';
import '../service/equipamento_service.dart';
import '../service/ticket_service.dart';
import '../tools/constants.dart';
import '../tools/utils.dart';
import 'ticket_usuario_dialog.dart';
import 'widgets.dart';

class TicketsUsuario extends StatefulWidget {
  const TicketsUsuario({super.key, this.initialFilter});

  final Map<String, dynamic>? initialFilter;

  static String get routeName => "${Constants.baseHrefStripped}/tickets";

  @override
  State<TicketsUsuario> createState() => _TicketsUsuarioState();
}

class _TicketsUsuarioState extends State<TicketsUsuario> {
  List<Map<String, dynamic>>? listaEquipamentos;
  List<Map<String, dynamic>>? listaCategorias;
  List<Map<String, dynamic>>? listaStatuses;
  UsuarioDTO? usuarioDTO;

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
        UsuarioService.usuario.then(
          (value) => usuarioDTO = value,
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
            defaultFilter: {
              'usuarioId': usuarioDTO!.id!,
            },
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
                  return statusController.value = value;
                },
                'widget': DropdownFormField(
                  list: [
                    ...?listaStatuses?.map(
                      (e) => DropdownMenuEntry<String?>(
                        value: e['codigo'],
                        label: e['descricao'],
                      ),
                    ),
                  ],
                  controller: statusController,
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
                  return categoriaIdController.value = value;
                },
                'widget': DropdownFormField(
                  list: [
                    ...?listaCategorias?.map(
                      (e) => DropdownMenuEntry<int>(
                        value: e['id'],
                        label: e['nome'],
                      ),
                    ),
                  ],
                  controller: categoriaIdController,
                ),
              },
            ],
            onAdd: (rows) async {
              var equipamentosDisponiveis = listaEquipamentos
                  ?.where(
                    (element) => element['status'] == 'D',
                  )
                  .toList();

              if (equipamentosDisponiveis?.isEmpty ?? true) {
                await showDialog(
                  context: context,
                  builder: (context) => const AlertOkDialog(
                    title: Text("Aviso"),
                    content: Text("Nenhum equipamento disponível"),
                  ),
                );
                return;
              }

              var reservasFeitasHoje = rows?.where(
                (row) {
                  var currentDate = DateFormat("dd/MM/yyyy HH:mm").tryParse(
                    row.cells['dt_abertura']?.value as String? ?? "",
                  );

                  return (currentDate?.difference(DateTime.now()).inDays ?? 0) <
                      1;
                },
              ).toList();
              var categoriasEsgotadasHoje = <int>{};
              var reservasFiltradasHoje = reservasFeitasHoje?.where(
                (row) {
                  var categoriaId = row.cells['categoria']?.value as int?;
                  if (categoriaId == null) {
                    return true;
                  }

                  return categoriasEsgotadasHoje.add(categoriaId);
                },
              ).toList();
              equipamentosDisponiveis = equipamentosDisponiveis?.where(
                (element) {
                  return !categoriasEsgotadasHoje
                      .contains(element['categoriaId']);
                },
              ).toList();

              if (equipamentosDisponiveis?.isEmpty ?? true) {
                await showDialog(
                  context: context,
                  builder: (context) => const AlertOkDialog(
                    title: Text("Aviso"),
                    content: Text("Não é possível fazer mais reservas hoje"),
                  ),
                );
                return;
              }

              var result = await showDialog<List<int?>>(
                context: context,
                builder: (context) => const AddTicket(),
              );
              if (result != null) setState(() {});
            },
            doSearch: true, // TODO
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

                  rendererContext.cell.value = categoria?['id'];

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
