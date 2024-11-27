import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:techstock_front/pages/widgets.dart';

import '../service/categoria_service.dart';
import '../service/equipamento_service.dart';
import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'equipamento_dialog.dart';

class Equipamentos extends StatefulWidget {
  const Equipamentos({super.key, this.initialFilter});

  static String get routeName => "${Constants.baseHrefStripped}/equipamentos";

  final Map<String, dynamic>? initialFilter;

  @override
  State<Equipamentos> createState() => _EquipamentosState();
}

class _EquipamentosState extends State<Equipamentos> {
  List<Map<String, dynamic>>? listaCategorias;
  List<Map<String, dynamic>>? listaStatuses;

  List<Object?> errors = List.empty(growable: true);

  late final KeyValueNotifier<String, dynamic> filtro;
  final statusController = ValueNotifier<String?>(null);
  final categoriaIdController = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    filtro = KeyValueNotifier<String, dynamic>(
      widget.initialFilter ?? {},
    );
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final args = ModalRoute.of(context)!.settings.arguments
    //       as Arguments<Map<String, dynamic>>?;
    //   if (args?.value != null) {
    //     filtro.value = args!.value;
    //   }
    // });
    Future.wait(
      [
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
        EquipamentoService().listarStatuses().then(
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
      listaCategorias,
      listaStatuses,
    ].contains(null)
        ? BaseAppWithAuthCheck(
            title: "Equipamentos",
            child: errors.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(errors.join(','))),
          )
        : BaseDatabaseWidget(
            title: "Equipamentos",
            service: EquipamentoService(),
            onAdd: (controller) async {
              var result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (context) => AddEditEquipamento(),
              );
              if (result != null) setState(() {});
            },
            filtro: filtro,
            doSearch: true,
            filtroFields: [
              {
                'field': 'status',
                'label': "Status",
                'controller': statusController,
                'value_converter': (value) {
                  return statusController.value = value;
                },
                'widget': DropdownFormField(
                  list: listaStatuses
                      ?.map(
                        (e) => DropdownMenuEntry<String?>(
                          value: e['codigo'],
                          label: e['descricao'],
                        ),
                      )
                      .toList(),
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
                  list: listaCategorias
                      ?.map(
                        (e) => DropdownMenuEntry<int>(
                          value: e['id'],
                          label: e['nome'],
                        ),
                      )
                      .toList(),
                  controller: categoriaIdController,
                ),
              },
            ],
            prefixColumnRenderer: (PlutoColumnRendererContext rendererContext) {
              return IconButton(
                onPressed: () async {
                  var result = await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (context) => AddEditEquipamento(
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
              'tombamento': {
                'title': "Tombamento",
                'type': PlutoColumnType.text(),
              },
              'categoriaId': {
                'title': "Categoria",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  int? categoriaId = rendererContext.cell.value;

                  Map<String, dynamic>? categoria = listaCategorias
                      ?.where((element) => element['id'] == categoriaId)
                      .singleOrNull;

                  return Center(child: Text(categoria?['nome'] ?? "-"));
                },
              },
              'descricao': {
                'title': "Especificação do equipamento",
                'type': PlutoColumnType.text(),
              },
              'fabricante': {
                'title': "Fabricante",
                'type': PlutoColumnType.text(),
              },
              'status': {
                'title': "Status",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
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
                        await EquipamentoService().editarStatus(
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
              'dtEntrada': {
                'title': "Data de Entrada",
                'type': PlutoColumnType.text(),
              },
              'dtSaida': {
                'title': "Data de Saída",
                'type': PlutoColumnType.text(),
                'renderer': (PlutoColumnRendererContext rendererContext) {
                  return Center(child: Text(rendererContext.cell.value ?? ""));
                }
              }
            },
          );
  }
}
