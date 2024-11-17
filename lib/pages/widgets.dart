import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../service/service.dart';
import '../service/usuario_service.dart';
import '../tools/exceptions.dart';
import '../tools/utils.dart';
import 'login.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({
    super.key,
    this.title,
    required this.child,
  });

  final Widget? title;
  final Widget child;

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColorScheme(context).secondary,
        foregroundColor: getColorScheme(context).onSecondary,
        centerTitle: false,
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: kToolbarHeight,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: widget.title ?? Container()),
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
      backgroundColor: const Color(0xFFD6D6D6),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            width: MediaQuery.of(context).size.width - 20.0,
          ),
          child: widget.child,
        ),
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0).copyWith(bottom: 30.0),
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
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (_) => false,
                        ),
                      );
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
    );
  }
}

class BaseDatabaseWidget extends StatelessWidget {
  const BaseDatabaseWidget({
    super.key,
    required this.title,
    required this.service,
    required this.columns,
    this.controller,
    this.onSearch,
    this.onAdd,
    this.borderRadius,
    this.prefixColumnRenderer,
    this.prefixColumnWidth,
  });
  final IService service;
  final Map<String, Map<String, dynamic>> columns;
  final BorderRadiusGeometry? borderRadius;

  final String title;

  final TextEditingController? controller;
  final void Function(TextEditingController controller)? onSearch;

  final void Function(TextEditingController controller)? onAdd;

  final Widget Function(
    PlutoColumnRendererContext rendererContext,
  )? prefixColumnRenderer;
  final double? prefixColumnWidth;

  @override
  Widget build(BuildContext context) {
    var controller = this.controller ?? TextEditingController();

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.rubik(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 42,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
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
                            onPressed: onSearch != null
                                ? () => onSearch!(controller)
                                : null,
                            child: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
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
                          onPressed: onAdd != null //
                              ? () => onAdd!(controller)
                              : null,
                          label: const Text("Adicionar"),
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 25.0),
        Expanded(
          child: FutureBuilder(
            future: service.listar(),
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
                      field: e.key,
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
                rows: List.generate(
                  snapshot.data?.length ?? 0,
                  (index) => PlutoRow.fromJson({
                    '__prefix': null,
                    ...snapshot.data![index],
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AlertOkDialog extends StatelessWidget {
  final Widget? title;

  final Widget? content;

  final EdgeInsets? insetPadding;

  final String okString;

  const AlertOkDialog({
    super.key,
    this.title,
    this.content,
    this.insetPadding,
    this.okString = "OK",
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
            Navigator.pop(context, true);
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
    );
  }
}
