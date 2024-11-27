import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../service/service.dart';
import '../service/ticket_service.dart';
import '../service/usuario_service.dart';
import '../tools/constants.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({
    super.key,
    required this.child,
    this.titleActions,
    this.leading,
    this.appBarTitle,
    this.titleAlignment,
    required this.scaffoldKey,
    this.endDrawer,
  });

  final List<Widget>? titleActions;
  final Widget child;
  final Widget? leading;
  final Widget? appBarTitle;
  final AlignmentGeometry? titleAlignment;

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: getColorScheme(context).secondary,
        foregroundColor: getColorScheme(context).onSecondary,
        centerTitle: false,
        leading: leading,
        actions: [Container()],
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: kToolbarHeight,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
              const VerticalDivider(color: Colors.transparent),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/images/image_branca.png'),
              ),
            ],
          ),
        ),
      ),
      drawer: GlobalDrawer(),
      endDrawer: endDrawer,
      backgroundColor: const Color(0xFFD6D6D6),
      body: child,
    );
  }
}

class BaseAppWithAuthCheck extends StatelessWidget {
  const BaseAppWithAuthCheck({
    super.key,
    required this.title,
    required this.child,
    this.titleActions,
    this.leading,
    this.titleAlignment,
    this.scaffoldKey,
    this.endDrawer,
  });

  final String title;
  final List<Widget>? titleActions;
  final Widget child;
  final Widget? leading;
  final AlignmentGeometry? titleAlignment;

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? endDrawer;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = this.scaffoldKey ?? GlobalKey<ScaffoldState>();

    return FutureBuilder(
      future: TicketService().listar(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          UsuarioService().logout().then((_) => returnToLogin(context));
          return Container();
        }

        return BaseApp(
          scaffoldKey: scaffoldKey,
          endDrawer: endDrawer,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(
                width: MediaQuery.of(context).size.width - 20.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: titleAlignment ?? Alignment.centerLeft,
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    color: getColorScheme(context).secondary),
                          ),
                        ),
                      ),
                      if (titleActions != null)
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: titleActions!,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Divider(height: 25.0),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GlobalDrawer extends StatelessWidget {
  const GlobalDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/image.png'),
            FutureBuilder(
              future: UsuarioService.usuario,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    const Divider(color: Colors.transparent),
                    Text(
                      snapshot.data?.nome ?? "-",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(color: Colors.transparent),
                    Text(
                      snapshot.data?.email ?? "-",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(color: Colors.transparent),
                  ],
                );
              },
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                    future: UsuarioService.usuario,
                    builder: (context, snapshot) {
                      return Column(
                        children: Constants.telas
                            .where(
                              (element) {
                                if (snapshot.data == null) return false;

                                var usuario = snapshot.data!;

                                if (usuario.permissions!
                                    .contains('ROLE_ADMIN')) {
                                  return element['role'] == 'ROLE_ADMIN';
                                }

                                return element['role'] == 'ROLE_USER';
                              },
                            )
                            .map(
                              (e) => Builder(
                                builder: (context) {
                                  var hovering = false;
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return MouseRegion(
                                        onEnter: (event) =>
                                            setState(() => hovering = true),
                                        onExit: (event) =>
                                            setState(() => hovering = false),
                                        child: ListTile(
                                          title: Text(
                                            e['title'],
                                            style: TextStyle(
                                              color: hovering
                                                  ? getColorScheme(context)
                                                      .onPrimary
                                                  : getColorScheme(context)
                                                      .onSurface,
                                            ),
                                          ),
                                          leading: Icon(
                                            e['icon'],
                                            color: hovering
                                                ? getColorScheme(context)
                                                    .onPrimary
                                                : getColorScheme(context)
                                                    .onSurface,
                                          ),
                                          style: ListTileStyle.drawer,
                                          hoverColor: hovering
                                              ? getColorScheme(context).primary
                                              : getColorScheme(context).surface,
                                          onTap: () =>
                                              Navigator.pushReplacementNamed(
                                            context,
                                            e['route'],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                      );
                    }),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FilledButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => FutureBuilder(
                    future: UsuarioService().logout(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          var error = snapshot.error;
                          if (error is ServiceException) {
                            return AlertOkDialog(
                              title: const Text("Erro"),
                              content: Text(error.cause),
                            );
                          }
                          return UnknownErrorDialog(
                            exception: error!,
                            stacktrace: snapshot.stackTrace!,
                          );
                        }
                        returnToLogin(context);
                        return Container();
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                style: ButtonStyle(
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    getColorScheme(context).surfaceContainer,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    getColorScheme(context).onSurface,
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: const Text("Sair"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BaseDatabaseWidget extends StatelessWidget {
  const BaseDatabaseWidget({
    super.key,
    required this.title,
    required this.service,
    required this.columns,
    this.searchController,
    this.doSearch = false,
    this.onAdd,
    this.borderRadius,
    this.prefixColumnRenderer,
    this.prefixColumnWidth,
    this.filtro,
    this.filtroFields,
    this.scaffoldKey,
  });

  final String title;

  final IService service;
  final Map<String, Map<String, dynamic>> columns;
  final BorderRadiusGeometry? borderRadius;

  final TextEditingController? searchController;
  final bool doSearch;

  final FutureOr<void> Function(List<PlutoRow>? rows)? onAdd;

  final Widget Function(
    PlutoColumnRendererContext rendererContext,
  )? prefixColumnRenderer;
  final double? prefixColumnWidth;

  final KeyValueNotifier<String, dynamic>? filtro;
  final List<Map<String, dynamic>>? filtroFields;

  final GlobalKey<ScaffoldState>? scaffoldKey;

  void onSearch(TextEditingController controller) {
    filtro?['query'] = controller.text;
  }

  @override
  Widget build(BuildContext context) {
    final searchController = this.searchController ?? TextEditingController();
    final scaffoldKey = this.scaffoldKey ?? GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();

    var mapFields = <String,
        (
      ValueNotifier,
      dynamic Function(
        dynamic value,
      ),
    )>{};

    List<PlutoRow>? rowList;

    return BaseAppWithAuthCheck(
      scaffoldKey: scaffoldKey,
      endDrawer: [filtro, filtroFields].contains(null)
          ? null
          : Drawer(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Filtrar por",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: getColorScheme(context).secondary),
                    ),
                    const Divider(height: 40.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: filtroFields!.map(
                              (current) {
                                ValueNotifier controller =
                                    current['controller'] ??
                                        TextEditingController();
                                dynamic Function(
                                  dynamic value,
                                ) valueConverter = current['value_converter'] ??
                                    (value) {
                                      return value?.toString();
                                    };

                                mapFields[current['field']!] = (
                                  controller,
                                  valueConverter,
                                );

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (current['label'] != null)
                                        Text(
                                          current['label'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: getColorScheme(context)
                                                    .secondary,
                                              ),
                                        ),
                                      current['widget'] ??
                                          TextFormField(
                                            controller:
                                                mapFields[current['field']!]
                                                    as TextEditingController,
                                            validator: current['validator'] ??
                                                stringValidator,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() != true) {
                                return;
                              }

                              var newFilter = <String, dynamic>{};
                              for (var field in mapFields.entries) {
                                var newValue =
                                    field.value.$2(field.value.$1.value);
                                newFilter[field.key] = newValue;
                              }

                              newFilter.removeWhere(
                                (_, value) => value == null,
                              );

                              filtro!.value = newFilter;

                              scaffoldKey.currentState?.closeEndDrawer();
                            },
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
                            child: const Text("Filtrar"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilledButton(
                            onPressed: () {},
                            child: Text("Voltar"),
                            style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              backgroundColor: WidgetStatePropertyAll(
                                getColorScheme(context).surfaceContainerHighest,
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                getColorScheme(context).onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      title: title,
      titleActions: [
        if (![filtro, filtroFields].contains(null))
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton.filled(
              // TODO
              onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              icon: const Icon(Icons.filter_alt),
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
        if (filtro != null && doSearch)
          Expanded(
            child: TextFormField(
              controller: searchController,
              onFieldSubmitted: (_) => onSearch(searchController),
              decoration: InputDecoration(
                filled: true,
                hintText: "Pesquisar...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () => onSearch(searchController),
                  child: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        if (onAdd != null)
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              height: 42,
              child: FilledButton.icon(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                onPressed: () => onAdd!(rowList),
                label: const Text("Adicionar"),
                icon: const Icon(Icons.add),
              ),
            ),
          ),
      ],
      child: ListenableBuilder(
        listenable: Listenable.merge([filtro]),
        builder: (context, _) {
          return FutureBuilder(
            future: service.listar(filtro: filtro?.value),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                var error = snapshot.error!;
                var stackTrace = snapshot.stackTrace!;

                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    if (error is ServiceException) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertOkDialog(
                          title: const Text("Erro"),
                          content: Text(error.toString()),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => UnknownErrorDialog(
                          exception: error,
                          stacktrace: stackTrace,
                        ),
                      );
                    }
                  },
                );

                return Center(child: Text(error.toString()));
              }

              return PlutoGrid(
                configuration: PlutoGridConfiguration(
                  columnSize: const PlutoGridColumnSizeConfig(
                    resizeMode: PlutoResizeMode.none,
                    autoSizeMode: PlutoAutoSizeMode.scale,
                  ),
                  style: Theme.of(context).brightness == Brightness.dark
                      ? PlutoGridStyleConfig.dark(
                          gridBorderRadius: borderRadius ?? BorderRadius.zero,
                          enableColumnBorderVertical: true,
                        )
                      : PlutoGridStyleConfig(
                          gridBorderRadius: borderRadius ?? BorderRadius.zero,
                          enableColumnBorderVertical: true,
                        ),
                ),
                columns: [
                  if (prefixColumnRenderer != null)
                    PlutoColumn(
                      width: prefixColumnWidth ?? PlutoGridSettings.columnWidth,
                      type: PlutoColumnType.select([]),
                      titlePadding: EdgeInsets.zero,
                      title: '',
                      minWidth: 0,
                      suppressedAutoSize: true,
                      renderer: prefixColumnRenderer,
                      readOnly: true,
                      filterPadding: EdgeInsets.zero,
                      field: '__prefix',
                      enableSorting: false,
                      enableDropToResize: false,
                      enableContextMenu: false,
                      cellPadding: EdgeInsets.zero,
                      enableEditingMode: false,
                    ),
                  ...columns.entries.map((e) {
                    var current = e.value;

                    return PlutoColumn(
                      width:
                          Theme.of(context).textTheme.titleMedium!.fontSize! *
                              10,
                      type: current['type'],
                      title: current['title'],
                      field: current['field'] ?? e.key,
                      titleTextAlign: PlutoColumnTextAlign.center,
                      textAlign: PlutoColumnTextAlign.center,
                      readOnly: !(current['canEdit'] ?? false),
                      enableEditingMode: current['canEdit'] ?? false,
                      suppressedAutoSize:
                          current['suppressedAutoSize'] ?? false,
                      renderer: current['renderer'],
                      enableDropToResize: false,
                      enableContextMenu: false,
                    );
                  })
                ],
                rows: rowList = List.generate(
                  snapshot.data?.length ?? 0,
                  (index) {
                    columns;
                    var plutoRow = PlutoRow.fromJson({
                      '__prefix': null,
                      ...snapshot.data![index],
                      ...Map.fromEntries(columns.entries
                          .where(
                            (element) => element.value['field'] != null,
                          )
                          .map(
                            (e) => MapEntry(e.value['field'], null),
                          )),
                    });
                    return plutoRow;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AlertOkDialog extends StatelessWidget {
  final Widget? title;

  final Widget? content;

  final EdgeInsets? insetPadding;

  final String okString;

  final Object? okReturn;

  const AlertOkDialog({
    super.key,
    this.title,
    this.content,
    this.insetPadding,
    this.okString = "OK",
    this.okReturn = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: insetPadding ??
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, okReturn);
          },
          child: Text(okString),
        )
      ],
    );
  }
}

class AlertOkCancelDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final String noString;
  final String yesString;

  const AlertOkCancelDialog({
    super.key,
    this.title,
    this.content,
    this.noString = "Cancelar",
    this.yesString = "Ok",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(noString),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(yesString),
        ),
      ],
    );
  }
}

class UnknownErrorDialog extends StatelessWidget {
  const UnknownErrorDialog({
    super.key,
    this.message = "Ocorreu um erro desconhecido."
        " Entre em contato com o suporte caso ele persista.",
    required this.exception,
    required this.stacktrace,
  });

  final String message;
  final Object exception;
  final StackTrace stacktrace;

  @override
  Widget build(BuildContext context) {
    debugPrintStack(stackTrace: stacktrace);

    return AlertOkDialog(
      title: const Text("Erro desconhecido"),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 2,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "$message (${exception.runtimeType})",
              ),
              Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  stacktrace.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      okReturn: null,
    );
  }
}

class BaseAddEditDialog extends StatefulWidget {
  const BaseAddEditDialog({
    super.key,
    required this.fields,
    required this.title,
    this.confirmButtonLabel,
    this.confirmButtonCallback,
    this.deleteButtonCallback,
    this.cancelButtonLabel,
  });
  final String title;

  final Widget? confirmButtonLabel;
  final FutureOr<void> Function(
    Map<String, dynamic>? result,
  )? confirmButtonCallback;

  final FutureOr<void> Function(
    Map<String, dynamic>? result,
  )? deleteButtonCallback;

  final Widget? cancelButtonLabel;

  final List<Map<String, dynamic>> fields;

  @override
  State<BaseAddEditDialog> createState() => _BaseAddEditDialogState();
}

class _BaseAddEditDialogState extends State<BaseAddEditDialog> {
  final formKey = GlobalKey<FormState>();
  List<
      (
        String fieldName,
        TextEditingController controller,
        dynamic Function(String value)? converter,
      )> resultTuples = [];

  Map<String, dynamic> get result {
    return Map.fromEntries(resultTuples.map(
      (e) {
        dynamic valueTreated;
        if (e.$3 != null) {
          valueTreated = e.$3!(e.$2.text);
        } else {
          valueTreated = e.$2.text;
        }
        return MapEntry(e.$1, valueTreated);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fontSize = textTheme.bodyMedium!.fontSize!;

    return BaseApp(
      scaffoldKey: null,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: getColorScheme(context).secondary),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...widget.fields.map(
                        (map) {
                          Widget createField(Map<String, dynamic> signature) {
                            var controller = TextEditingController(
                              text: signature['defaultText']?.toString(),
                            );
                            var inputDecoration = InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: signature['hint'] as String?,
                            );
                            if (signature['empty'] != true) {
                              resultTuples.add((
                                signature['field_name'],
                                controller,
                                signature['converter'],
                              ));
                            }
                            Widget widget;
                            if (signature['fieldBuilder'] != null) {
                              Widget Function(
                                TextEditingController controller,
                              ) builder = signature['fieldBuilder'];
                              widget = builder(controller);
                            } else {
                              bool showPassword = signature['obscure'] == null;
                              widget = StatefulBuilder(
                                builder: (context, setInnerState) {
                                  return TextFormField(
                                    controller: controller,
                                    obscureText: !showPassword,
                                    decoration: inputDecoration.copyWith(
                                      suffixIcon: signature['obscure'] != null
                                          ? IconButton(
                                              onPressed: () =>
                                                  setInnerState(() {
                                                showPassword = !showPassword;
                                              }),
                                              icon: Icon(
                                                showPassword
                                                    ? Icons
                                                        .visibility_off_outlined
                                                    : Icons.visibility_outlined,
                                              ),
                                            )
                                          : null,
                                    ),
                                    validator: (value) {
                                      if (signature['validator'] != null) {
                                        return signature['validator']!(value);
                                      }

                                      if (value?.isEmpty ?? true) {
                                        return "Campo não pode ser vazio";
                                      }
                                      return null;
                                    },
                                  );
                                },
                              );
                            }

                            return SizedBox(
                              width: fontSize * 25,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (signature['label'] != null)
                                      DefaultTextStyle(
                                        style: textTheme.titleLarge!,
                                        child: signature['label'] as Widget,
                                      ),
                                    signature['empty'] == true
                                        ? TextFormField(
                                            decoration:
                                                inputDecoration.copyWith(
                                              enabled: false,
                                            ),
                                          )
                                        : widget,
                                  ],
                                ),
                              ),
                            );
                          }

                          if (map['children'] != null) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...(map['children']
                                          as List<Map<String, dynamic>>)
                                      .map(
                                    (signatureInner) {
                                      return createField(signatureInner);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }

                          return createField(map);
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            const EdgeInsets.all(25.0).add(
                              const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            getColorScheme(context).secondaryContainer,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            getColorScheme(context).onSecondaryContainer,
                          ),
                        ),
                        child: widget.cancelButtonLabel ??
                            Text(
                              "Voltar",
                              style: TextStyle(
                                fontSize: textTheme.titleMedium!.fontSize!,
                              ),
                            ),
                      ),
                    ),
                    if (widget.deleteButtonCallback != null)
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FilledButton(
                          onPressed: () async {
                            return await widget.deleteButtonCallback!(result);
                          },
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              const EdgeInsets.all(25.0).add(
                                const EdgeInsets.symmetric(horizontal: 20.0),
                              ),
                            ),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              getColorScheme(context).errorContainer,
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              getColorScheme(context).onErrorContainer,
                            ),
                          ),
                          child: widget.confirmButtonLabel ??
                              Text(
                                "Excluir",
                                style: TextStyle(
                                  fontSize: textTheme.titleMedium!.fontSize!,
                                ),
                              ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FilledButton(
                        onPressed: () async {
                          if (formKey.currentState?.validate() != true) return;

                          if (widget.confirmButtonCallback != null) {
                            return await widget.confirmButtonCallback!(result);
                          }

                          Navigator.pop(context, result);
                        },
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(
                            const EdgeInsets.all(25.0).add(
                              const EdgeInsets.symmetric(horizontal: 20.0),
                            ),
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll(
                            Colors.green,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            getContrastColor(Colors.green),
                          ),
                        ),
                        child: widget.confirmButtonLabel ??
                            Text(
                              "SALVAR",
                              style: TextStyle(
                                fontSize: textTheme.titleMedium!.fontSize!,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateFormField extends StatelessWidget {
  const DateFormField({
    super.key,
    required this.dataController,
    this.validator,
    this.decoration,
    this.label,
  });

  final ValueNotifier<DateTime?> dataController;

  final String? Function(DateTime? value)? validator;

  final InputDecoration? decoration;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    var formField = FormField<DateTime>(
      initialValue: dataController.value,
      validator: validator ??
          (value) {
            if (value == null) {
              return "Campo não pode ser vazio";
            }
            return null;
          },
      builder: (state) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => dataController.value = state.value,
        );
        var inputDecoration = decoration ?? InputDecoration();
        return InputDecorator(
          decoration: inputDecoration.copyWith(
            border: OutlineInputBorder(),
            errorText: state.errorText,
            errorMaxLines: 2,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => state.didChange(dataController.value = null),
                  icon: Icon(Icons.close),
                ),
                IconButton(
                  onPressed: () => showDatePicker(
                    locale: const Locale('pt'),
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
              ],
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
    );

    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label!,
          formField,
        ],
      );
    }
    return formField;
  }
}

class DropdownFormField<T> extends StatelessWidget {
  const DropdownFormField({
    super.key,
    required this.list,
    required this.controller,
    this.validator,
    this.decorationTheme,
    this.label,
    this.initialValue,
  });

  final List<DropdownMenuEntry<T?>>? list;

  final ValueNotifier<T?> controller;

  final String? Function(T? value)? validator;

  final InputDecorationTheme? decorationTheme;

  final Widget? label;

  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    assert(validator == null && label == null);

    return FormField<T?>(
      builder: (state) {
        return DropdownMenu<T?>(
          initialSelection: controller.value,
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: decorationTheme,
          enableFilter: true,
          filterCallback: (entries, filter) {
            return [
              entries.singleWhere((e) => e.value == null),
              ...entries.where((element) {
                if (element.value == null) return false;
                return element.label.contains(filter);
              })
            ];
          },
          onSelected: (value) {
            controller.value = value;
          },
          dropdownMenuEntries: [
            const DropdownMenuEntry(
              value: null,
              label: "",
            ),
            ...?list,
          ],
        );
      },
    );
  }
}
