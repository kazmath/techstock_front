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

  Map<String, dynamic>? get result {
    if (formKey.currentState?.validate() != true) return null;
    var temp = equipamentoFieldGroups.values.map(
      (e) {
        return {
          'equipamentoId': e.$2.value!,
          'dt_reserva': DateFormat("yyyy-MM-dd").format(e.$3.value!),
          'observacao': observacaoController.text,
        };
      },
    ).toList();
    Future.wait(
      temp.map(
        (e) => TicketService().add(e),
      ),
    ).then(
      (value) {
        Navigator.pop(context, value);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => showDialog(
            context: context,
            builder: (context) => AlertOkDialog(
              title: Text("Sucesso"),
              content: Text("Reservas feitas com sucesso"),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseApp(
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
                    "Adicionar Equipamentos",
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
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.red),
                            foregroundColor: WidgetStatePropertyAll(
                              getContrastColor(Colors.red),
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
                          onPressed: () {
                            result;
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.green),
                            foregroundColor: WidgetStatePropertyAll(
                              getContrastColor(Colors.green),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categoria",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FormField<int>(
                        initialValue: listaCategorias.first['id'] as int,
                        builder: (state) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => categoriaController.value = state.value,
                          );
                          return DropdownMenu<int>(
                            initialSelection:
                                listaCategorias.first['id'] as int,
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
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Equipamento",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ListenableBuilder(
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
                                    (_) => equipamentoController.value =
                                        state.value,
                                  );
                                  return DropdownMenu<int>(
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
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data de Reserva",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FormField<DateTime>(
                        validator: (value) {
                          if (value == null) {
                            return "Campo não pode ser vazio";
                          }
                          return null;
                        },
                        builder: (state) {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (_) => dataController.value = state.value,
                          );
                          return InputDecorator(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              errorStyle: TextStyle(fontSize: 0),
                              errorText: state.errorText,
                              suffixIcon: IconButton(
                                onPressed: () => showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    Duration(days: 1000),
                                  ),
                                  initialDate: state.value,
                                ).then(
                                  (value) {
                                    if (value == null) return;
                                    state.didChange(value);
                                  },
                                ),
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                            child: Text(
                              state.value != null
                                  ? DateFormat("dd/MM/yyyy").format(
                                      state.value!,
                                    )
                                  : "dd/MM/yyyy",
                            ),
                          );
                        },
                      ),
                    ],
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
