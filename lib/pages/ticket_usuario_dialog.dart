// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techstock_front/service/categoria_service.dart';
import 'package:techstock_front/service/equipamento_service.dart';
import 'package:techstock_front/service/ticket_service.dart';
import 'package:techstock_front/tools/utils.dart';

import '../pages/widgets.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({super.key, this.editMap});

  final Map<String, dynamic>? editMap;

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final equipamentoFieldGroups = <Key,
      (
    Widget,
    ValueNotifier<int?>,
    ValueNotifier<DateTime?>,
  )>{};
  final observacaoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Map<String, dynamic>?> evaluateResults() async {
    if (formKey.currentState?.validate() != true) return null;
    if (equipamentoFieldGroups.isEmpty) return null;
    var temp = equipamentoFieldGroups.values.map(
      (e) {
        return {
          'equipamentoId': e.$2.value!,
          'dt_reserva': DateFormat("yyyy-MM-dd").format(e.$3.value!),
        };
      },
    ).toList();
    temp[0]['observacao'] = observacaoController.text;

    List<int?>? resultAPI = await apiRequestDialog(
      context,
      Future.wait(
        temp.map(
          (e) => TicketService().add(e),
        ),
      ),
    );

    if (resultAPI == null) return null;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Navigator.pop(context, resultAPI);
        showDialog(
          context: context,
          builder: (context) => AlertOkDialog(
            title: Text("Sucesso"),
            content: Text("Reservas feitas com sucesso"),
          ),
        );
      },
    );
    // Future.wait(
    //   temp.map(
    //     (e) => TicketService().add(e),
    //   ),
    // ).then(
    //   (value) {
    //     WidgetsBinding.instance.addPostFrameCallback(
    //       (_) {
    //         Navigator.pop(context, value);
    //         showDialog(
    //           context: context,
    //           builder: (context) => AlertOkDialog(
    //             title: Text("Sucesso"),
    //             content: Text("Reservas feitas com sucesso"),
    //           ),
    //         );
    //       },
    //     );
    //   },
    //   onError: (error, stackTrace) {
    //     WidgetsBinding.instance.addPostFrameCallback(
    //       (_) {
    //         Navigator.pop(context);
    //         showDialog(
    //           context: context,
    //           builder: (context) => AlertOkDialog(
    //             title: Text("Sucesso"),
    //             content: Text("Reservas não foram feitas"),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BaseApp(
      scaffoldKey: scaffoldKey,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: min(
                  MediaQuery.of(context).size.width,
                  Theme.of(context).textTheme.bodyMedium!.fontSize! * 50,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reserva de Equipamentos",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Divider(color: Colors.transparent),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...equipamentoFieldGroups.values.map((e) => e.$1),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton.icon(
                            onPressed: () {
                              var currentFieldGroup =
                                  generateEquipamentoFieldGroup(context);

                              equipamentoFieldGroups[currentFieldGroup
                                  .$1.key!] = currentFieldGroup;
                              setState(() {});
                            },
                            label: Text("Adicionar Equipamento"),
                            icon: Icon(Icons.add),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                getColorScheme(context).primary,
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                getColorScheme(context).onPrimary,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 30,
                          color: Colors.transparent,
                        ),
                        Text(
                          "Observação",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          maxLines: 5,
                          controller: observacaoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.transparent),
                  Text(
                    "* Campos obrigatórios",
                    style: TextStyle(
                      color: getColorScheme(context).error,
                    ),
                  ),
                  Divider(color: Colors.transparent),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              getColorScheme(context).errorContainer,
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              getColorScheme(context).onErrorContainer,
                            ),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.all(15.0),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text("Cancelar"),
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                        child: FilledButton(
                          onPressed: evaluateResults,
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xFF4CAF50),
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              Color(0xFFFFFFFF),
                            ),
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.all(15.0),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text("Salvar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  (
    Widget widget,
    ValueNotifier<int?> equipamentoController,
    ValueNotifier<DateTime?> dataController,
  ) generateEquipamentoFieldGroup(BuildContext context) {
    final categoriaController = ValueNotifier<int?>(null);
    final equipamentoController = ValueNotifier<int?>(null);
    final dataController = ValueNotifier<DateTime?>(null);
    var uniqueKey = UniqueKey();

    final widget = FutureBuilder(
      key: uniqueKey,
      future: CategoriaService().listar(),
      builder: (context, snapshot) {
        final listaCategorias = snapshot.data;

        if (listaCategorias == null) {
          return LinearProgressIndicator();
        }
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      equipamentoFieldGroups.remove(uniqueKey);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.delete_outline,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        getColorScheme(context).errorContainer,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        getColorScheme(context).onErrorContainer,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FormField<int>(
                    initialValue: listaCategorias.firstOrNull?['id'] as int?,
                    builder: (state) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => categoriaController.value = state.value,
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categoria",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownMenu<int>(
                            initialSelection:
                                listaCategorias.firstOrNull?['id'] as int?,
                            expandedInsets:
                                EdgeInsets.all(8.0).copyWith(left: 0),
                            onSelected: (value) => state.didChange(value),
                            dropdownMenuEntries: snapshot.data
                                    ?.map(
                                      (e) => DropdownMenuEntry<int>(
                                        value: e['id'],
                                        label: e['nome'],
                                      ),
                                    )
                                    .toList() ??
                                [],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListenableBuilder(
                    listenable: categoriaController,
                    builder: (context, _) {
                      equipamentoController.value = null;
                      var _fieldController = TextEditingController();

                      return FutureBuilder(
                        future: categoriaController.value == null
                            ? Future.value([])
                            : EquipamentoService().listar(
                                filtro: {
                                  'categoriaId': categoriaController.value,
                                },
                              ),
                        builder: (context, snapshot) {
                          return FormField<int?>(
                            validator: (value) {
                              if (value == null) {
                                return "Campo não pode ser vazio";
                              }
                              return null;
                            },
                            builder: (state) {
                              WidgetsBinding.instance.addPostFrameCallback(
                                (_) =>
                                    equipamentoController.value = state.value,
                              );
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Equipamento *",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  DropdownMenu<int>(
                                    controller: _fieldController,
                                    enabled: snapshot.data != null,
                                    inputDecorationTheme: InputDecorationTheme(
                                      border: OutlineInputBorder(),
                                      errorStyle: TextStyle(fontSize: 0),
                                    ),
                                    enableFilter: true,
                                    filterCallback: (entries, filter) {
                                      return entries
                                          .where(
                                            (element) =>
                                                element.label.contains(filter),
                                          )
                                          .toList();
                                    },
                                    errorText: state.errorText,
                                    expandedInsets:
                                        EdgeInsets.all(8.0).copyWith(left: 0),
                                    dropdownMenuEntries: snapshot.data
                                            ?.map(
                                              (e) => DropdownMenuEntry<int>(
                                                value: e['id'],
                                                label: e['nome'],
                                              ),
                                            )
                                            .toList() ??
                                        [],
                                    onSelected: (value) {
                                      state.didChange(value);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: DateFormField(
                    label: Text(
                      "Data de Reserva *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 0),
                    ),
                    dataController: dataController,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    return (widget, equipamentoController, dataController);
  }
}
