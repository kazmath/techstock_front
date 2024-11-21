import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:techstock_front/pages/widgets.dart';
import 'package:techstock_front/service/categoria_service.dart';
import 'package:techstock_front/service/equipamento_service.dart';
import 'package:techstock_front/tools/utils.dart';

import '../tools/constants.dart';

class Equipamentos extends StatefulWidget {
  const Equipamentos({super.key});

  static String get routeName => "${Constants.baseHrefStripped}/equipamentos";

  @override
  State<Equipamentos> createState() => _EquipamentosState();
}

class _EquipamentosState extends State<Equipamentos> {
  List<Map<String, dynamic>>? listaCategorias;
  List<Map<String, dynamic>>? listaStatuses;

  List<Object?> errors = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
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
            onAdd: (controller) {}, // TODO
            onSearch: (controller) {}, // TODO
            prefixColumnRenderer: (rendererContext) {
              // TODO
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

                  int? cor = int.tryParse(
                    (status?['corHex'] as String?)?.substring(1) ?? '',
                    radix: 16,
                  );

                  // TODO: Editável com DropdownMenu
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
