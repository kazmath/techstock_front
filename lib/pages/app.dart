import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../tools/constants.dart';
import '../tools/utils.dart';
import 'widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return BaseApp(
      child: FutureBuilder(
        future: apiRequest("${Constants.apiURL}/usuario"),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var (
            List<Map<String, dynamic>>? responseBody,
            List<String> responseErrors,
          ) = destructureResponse<List<Map<String, dynamic>>>(snapshot.data!);

          return PlutoGrid(
            configuration: PlutoGridConfiguration(
              columnSize: const PlutoGridColumnSizeConfig(
                resizeMode: PlutoResizeMode.none,
                autoSizeMode: PlutoAutoSizeMode.scale,
              ),
              style: Theme.of(context).brightness == Brightness.dark
                  ? const PlutoGridStyleConfig.dark(
                      gridBorderColor: Colors.transparent,
                      borderColor: Colors.transparent,
                    )
                  : const PlutoGridStyleConfig(
                      gridBorderColor: Colors.transparent,
                      borderColor: Colors.transparent,
                    ),
            ),
            columns: <PlutoColumn>[
              PlutoColumn(
                width: Theme.of(context).textTheme.titleMedium!.fontSize! * 10,
                type: PlutoColumnType.number(),
                titleTextAlign: PlutoColumnTextAlign.center,
                titleSpan: const WidgetSpan(
                  child: Text(
                    "Prioridade",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                title: 'Prioridade',
                textAlign: PlutoColumnTextAlign.center,
                suppressedAutoSize: true,
                field: 'prioridade',
                enableDropToResize: false,
                enableContextMenu: false,
              ),
            ],
            rows: List.generate(
              responseBody?.length ?? 0,
              (index) => PlutoRow.fromJson(responseBody![index]),
            ),
          );
        },
      ),
    );
  }
}
