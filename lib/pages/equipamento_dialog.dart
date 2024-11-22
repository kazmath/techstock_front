// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:techstock_front/service/categoria_service.dart';
import 'package:techstock_front/service/equipamento_service.dart';

import '../pages/widgets.dart';
import '../tools/utils.dart';

class AddEditEquipamento extends StatelessWidget {
  const AddEditEquipamento({super.key, this.editMap});

  final Map<String, dynamic>? editMap;

  @override
  Widget build(BuildContext context) {
    return BaseAddEditDialog(
      title: "${editMap != null ? "Editar" : "Cadastro de"} Equipamento",
      deleteButtonCallback: editMap?['id'] != null
          ? (result) async {
              if (result == null) return;
              int id = editMap!['id'];

              Map<String, dynamic>? resultAPI = await apiRequestDialog(
                context,
                Future(() async {
                  EquipamentoService().deletar(id);
                  return result;
                }),
              );

              if (resultAPI == null) return;

              Navigator.pop(context, result);
            }
          : null,
      confirmButtonCallback: (result) async {
        if (result == null) return;

        Map<String, dynamic>? resultAPI = await apiRequestDialog(
          context,
          Future(() async {
            if (editMap != null) {
              await EquipamentoService().editar(
                editMap!['id'],
                result,
              );
            } else {
              await EquipamentoService().add(result);
            }
            return result;
          }),
        );

        if (resultAPI == null) return;

        Navigator.pop(context, result);
      },
      fields: [
        {
          'children': [
            {
              'label': Text("Tombamento"),
              'field_name': 'tombamento',
              if (editMap != null) 'defaultText': editMap!['tombamento'],
            },
            {
              'label': Text("Nome"),
              'field_name': 'nome',
              if (editMap != null) 'defaultText': editMap!['nome'],
            },
          ]
        },
        {
          'children': [
            {
              'label': Text("Fabricante"),
              'field_name': 'fabricante',
              if (editMap != null) 'defaultText': editMap!['fabricante'],
            },
            {
              'label': Text("Ano de Fabricacao"),
              'field_name': 'ano_fabricacao',
              if (editMap != null) 'defaultText': editMap!['anoFabricacao'],
            },
          ],
        },
        {
          'children': [
            {
              'label': Text("Especificação do Equipamento"),
              'field_name': 'descricao',
              if (editMap != null) 'defaultText': editMap!['descricao'],
            },
            {
              'label': Text("Modelo"),
              'field_name': 'modelo',
              if (editMap != null) 'defaultText': editMap!['modelo'],
            },
          ],
        },
        {
          'children': [
            {
              'label': Text("Categoria"),
              'field_name': 'categoria',
              if (editMap != null) 'defaultText': editMap!['categoriaId'],
              'fieldBuilder': (TextEditingController controller) {
                return FutureBuilder(
                  future: CategoriaService().listar(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return InputDecorator(
                        decoration: InputDecoration(),
                        child: LinearProgressIndicator(),
                      );
                    }
                    editMap;
                    var initialValue = int.tryParse(controller.text);
                    return FormField<int>(
                      initialValue: initialValue,
                      validator: (value) {
                        if (value == null) {
                          return "Campo não pode ser vazio";
                        }
                        return null;
                      },
                      builder: (state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            errorText: state.errorText,
                            border: InputBorder.none,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropdownMenu<int>(
                                  initialSelection: initialValue,
                                  errorText: state.errorText,
                                  inputDecorationTheme: InputDecorationTheme(
                                    border: OutlineInputBorder(),
                                    errorStyle: TextStyle(fontSize: 0),
                                  ),
                                  expandedInsets: EdgeInsets.only(
                                    right: 4.0,
                                  ),
                                  onSelected: (value) {
                                    controller.text = value.toString();
                                    state.didChange(value);
                                  },
                                  dropdownMenuEntries: snapshot.data!.map(
                                    (e) {
                                      return DropdownMenuEntry(
                                        value: e['id'] as int,
                                        label: e['nome'],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              IconButton.filled(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.green,
                                  ),
                                  foregroundColor: WidgetStatePropertyAll(
                                    getContrastColor(Colors.green),
                                  ),
                                  iconColor: WidgetStatePropertyAll(
                                    getContrastColor(Colors.green),
                                  ),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        8.0,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            },
          ],
        },
      ],
    );
  }
}
