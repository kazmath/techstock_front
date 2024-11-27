// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:techstock_front/service/categoria_service.dart';
import 'package:techstock_front/service/equipamento_service.dart';
import 'package:techstock_front/theme.dart';
import 'package:techstock_front/tools/exceptions.dart';

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
                return StatefulBuilder(
                  builder: (context, setState) {
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
                                      inputDecorationTheme:
                                          InputDecorationTheme(
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
                                              labelWidget: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text.rich(
                                                      TextSpan(children: [
                                                        TextSpan(
                                                          text:
                                                              e['nome'] + "\n",
                                                        ),
                                                        TextSpan(
                                                          text: e['descricao'],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black45,
                                                                  ),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                  IconButton.filled(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                        getColorScheme(context)
                                                            .errorContainer,
                                                      ),
                                                      foregroundColor:
                                                          WidgetStatePropertyAll(
                                                        getColorScheme(context)
                                                            .onErrorContainer,
                                                      ),
                                                      iconColor:
                                                          WidgetStatePropertyAll(
                                                        getColorScheme(context)
                                                            .onErrorContainer,
                                                      ),
                                                      shape:
                                                          WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            8.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      var categoriaController =
                                                          TextEditingController();
                                                      var result =
                                                          await showDialog<
                                                              bool>(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertOkCancelDialog(
                                                          title: Text(
                                                              "Excluir Curso"),
                                                          yesString: "Sim",
                                                          noString: "Não",
                                                          content: Text(
                                                            "Tem certeza que deseja "
                                                            "remover o curso \"${e['nome']}\"",
                                                          ),
                                                        ),
                                                      );

                                                      if (!(result ?? false)) {
                                                        return;
                                                      }

                                                      try {
                                                        await CategoriaService()
                                                            .deletar(e['id']);
                                                      } on ServiceException catch (e) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertOkDialog(
                                                            title: Text("Erro"),
                                                            content:
                                                                Text(e.cause),
                                                          ),
                                                        );
                                                      }

                                                      setState(() {});
                                                    },
                                                    icon: Icon(Icons.remove),
                                                  ),
                                                ],
                                              ));
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  IconButton.filled(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        CustomMaterialTheme
                                            .salvarAprovado.value,
                                      ),
                                      foregroundColor: WidgetStatePropertyAll(
                                        getContrastColor(
                                          CustomMaterialTheme.salvarAprovado
                                              .light.onColorContainer,
                                        ),
                                      ),
                                      iconColor: WidgetStatePropertyAll(
                                        getContrastColor(
                                          CustomMaterialTheme.salvarAprovado
                                              .light.onColorContainer,
                                        ),
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      var categoriaController =
                                          TextEditingController();
                                      var descricaoController =
                                          TextEditingController();
                                      var result = await showDialog<bool>(
                                        context: context,
                                        builder: (context) =>
                                            AlertOkCancelDialog(
                                          title: Text("Adicionar Categoria"),
                                          yesString: "Confirmar",
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nome da Categoria a adicionar:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              TextFormField(
                                                controller: categoriaController,
                                                validator: stringValidator,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.transparent,
                                              ),
                                              Text(
                                                "Descrição da Categoria a adicionar:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              TextFormField(
                                                controller: descricaoController,
                                                validator: stringValidator,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );

                                      if (!(result ?? false)) return;

                                      try {
                                        await CategoriaService().add({
                                          'nome': categoriaController.text,
                                          'descricao': descricaoController.text,
                                        });
                                      } on ServiceException catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertOkDialog(
                                            title: Text("Erro"),
                                            content: Text(e.cause),
                                          ),
                                        );
                                      }

                                      setState(() {});
                                    },
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
                );
              },
            },
          ],
        },
      ],
    );
  }
}
