// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:techstock_front/tools/exceptions.dart';

import '../pages/widgets.dart';
import '../service/setor_service.dart';
import '../service/usuario_service.dart';
import '../tools/utils.dart';

class AddEditUsuario extends StatelessWidget {
  const AddEditUsuario({super.key, this.editMap});

  final Map<String, dynamic>? editMap;

  @override
  Widget build(BuildContext context) {
    return BaseAddEditDialog(
      title: "${editMap != null ? "Editar" : "Cadastro de"} Usuário",
      deleteButtonCallback: editMap?['id'] != null
          ? (result) async {
              if (result == null) return;
              int id = editMap!['id'];

              Map<String, dynamic>? resultAPI = await apiRequestDialog(
                context,
                Future(() async {
                  UsuarioService().deletar(id);
                  return result;
                }),
              );

              if (resultAPI == null) return;

              Navigator.pop(context, result);
            }
          : null,
      confirmButtonCallback: (result) async {
        if (result == null) return;
        int id = editMap!['id'];

        Map<String, dynamic>? resultAPI = await apiRequestDialog(
          context,
          Future(() async {
            if (editMap != null) {
              await UsuarioService().editar(
                id,
                result,
              );
            } else {
              await UsuarioService().add(result);
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
              'label': Text("Nome Completo"),
              'field_name': 'nome',
              if (editMap != null) 'defaultText': editMap!['nome'],
            },
            {
              'label': Text("Código"),
              'field_name': 'codigo',
              if (editMap != null) 'defaultText': editMap!['codigo'],
            },
          ]
        },
        {
          'children': [
            {
              'label': Text("Curso"),
              'field_name': 'setorId',
              if (editMap != null) 'defaultText': editMap!['setorId'],
              'converter': (String value) => int.tryParse(value),
              'fieldBuilder': (TextEditingController controller) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return FutureBuilder(
                      future: SetorService().listar(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return InputDecorator(
                            decoration: InputDecoration(),
                            child: LinearProgressIndicator(),
                          );
                        }

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
                                                  child: Text(e['nome']),
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
                                                    var setorController =
                                                        TextEditingController();
                                                    var result =
                                                        await showDialog<bool>(
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
                                                      await SetorService()
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
                                            ),
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
                                    onPressed: () async {
                                      var setorController =
                                          TextEditingController();
                                      var result = await showDialog<bool>(
                                        context: context,
                                        builder: (context) =>
                                            AlertOkCancelDialog(
                                          title: Text("Adicionar Curso"),
                                          yesString: "Confirmar",
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Nome do Curso a adicionar:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              TextFormField(
                                                controller: setorController,
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
                                        await SetorService().add({
                                          'nome': setorController.text,
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
            {
              'label': Text("E-mail"),
              'field_name': 'email',
              if (editMap != null) 'defaultText': editMap!['email'],
              'validator': (String value) {
                return RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$')
                        .hasMatch(value)
                    ? null
                    : "Email inválido";
              },
            },
          ]
        },
        {
          'children': [
            {
              'label': Text("Senha"),
              'field_name': 'senha',
              'defaultText': "",
              'obscure': true,
            },
            {
              'label': Text("Tipo de Usuário"),
              'field_name': 'usuarioTipo',
              if (editMap != null) 'defaultText': editMap!['usuarioTipo'],
              'fieldBuilder': (TextEditingController controller) {
                var initialValue = controller.text;
                return FormField<String>(
                  initialValue: initialValue,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
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
                      child: DropdownMenu<String>(
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
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                            value: 'ADMIN',
                            label: "Administrador",
                          ),
                          DropdownMenuEntry(
                            value: 'USER',
                            label: "Professor",
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            },
          ]
        },
      ],
    );
  }
}
