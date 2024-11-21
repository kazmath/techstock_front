// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:techstock_front/pages/widgets.dart';
import 'package:techstock_front/tools/exceptions.dart';
import 'package:techstock_front/tools/utils.dart';

import '../service/setor_service.dart';
import '../service/usuario_service.dart';
import '../tools/constants.dart';

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});
  static String get routeName => "${Constants.baseHrefStripped}/usuarios";

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
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
        showErrorDialog(context, error, stackTrace);
        setState(() {
          listaSetores = null;
          this.error = error;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return listaSetores == null
        ? BaseAppWithAuthCheck(
            title: "Usuário",
            child: error == null
                ? const Center(child: CircularProgressIndicator())
                : Center(child: Text(error!.toString())),
          )
        : BaseDatabaseWidget(
            title: "Usuário",
            service: UsuarioService(),
            onAdd: (controller) async {
              var result = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (context) => BaseAddEditDialog(
                  title: "Cadastro de Usuário",
                  confirmButtonCallback: (result) async {
                    if (result == null) return;

                    Map<String, dynamic>? resultAPI =
                        await showDialog<Map<String, dynamic>>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => PopScope(
                        canPop: false,
                        child: FutureBuilder(
                          future: UsuarioService().add(result),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Navigator.pop(context, result);
                            }

                            if (snapshot.hasError) {
                              if (snapshot.error is ServiceException) {
                                return AlertOkDialog(
                                  title: Text("Erro"),
                                  content: Text(
                                    (snapshot.error as ServiceException).cause,
                                  ),
                                );
                              }

                              return UnknownErrorDialog(
                                exception: snapshot.error!,
                                stacktrace: snapshot.stackTrace!,
                              );
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
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
                        },
                        {
                          'label': Text("Código"),
                          'field_name': 'codigo',
                        },
                      ]
                    },
                    {
                      'children': [
                        {
                          'label': Text("Setor"),
                          'field_name': 'setorId',
                          'converter': (String value) => int.tryParse(value),
                          'fieldBuilder': (TextEditingController controller) {
                            return FutureBuilder(
                              future: SetorService().listar(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return InputDecorator(
                                    decoration: InputDecoration(),
                                    child: LinearProgressIndicator(),
                                  );
                                }

                                return FormField<int>(
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
                                              errorText: state.errorText,
                                              inputDecorationTheme:
                                                  InputDecorationTheme(
                                                border: OutlineInputBorder(),
                                                errorStyle:
                                                    TextStyle(fontSize: 0),
                                              ),
                                              expandedInsets: EdgeInsets.only(
                                                right: 4.0,
                                              ),
                                              onSelected: (value) {
                                                controller.text =
                                                    value.toString();
                                                state.didChange(value);
                                              },
                                              dropdownMenuEntries:
                                                  snapshot.data!.map(
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
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.green,
                                              ),
                                              foregroundColor:
                                                  WidgetStatePropertyAll(
                                                getContrastColor(Colors.green),
                                              ),
                                              iconColor: WidgetStatePropertyAll(
                                                getContrastColor(Colors.green),
                                              ),
                                              shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                        {
                          'label': Text("E-mail"),
                          'field_name': 'email',
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
                        },
                        {
                          'label': Text("Tipo de Usuário"),
                          'field_name': 'usuarioTipo',
                          'fieldBuilder': (TextEditingController controller) {
                            return FormField<String>(
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
                                        label: "Usuário",
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
                ),
              );
              if (result != null) setState(() {});
            },
            onSearch: (controller) {},
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
          );

    // return BaseApp(
    //   child: Padding(
    //     padding: const EdgeInsets.all(30.0),
    //     child:  ,
    //   ),
    // );
  }
}
