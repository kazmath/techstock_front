// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:techstock_front/pages/equipamento_db.dart';
import 'package:techstock_front/pages/ticket_admin_db.dart';
import 'package:techstock_front/pages/widgets.dart';
import 'package:techstock_front/service/dashboard_service.dart';
import 'package:techstock_front/tools/utils.dart';

import '../tools/constants.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  static String get routeName => "${Constants.baseHrefStripped}/dashboard";

  @override
  Widget build(BuildContext context) {
    checkAuthOrReturnToLogin(context);

    return BaseAppWithAuthCheck(
      title: "Dashboard",
      child: FutureBuilder(
        future: DashboardService().get(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: TextStyle(color: Colors.white),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                        iconTheme: IconThemeData.fallback().copyWith(
                      color: Colors.white,
                    )),
                    child: Row(
                      children: [
                        {
                          'icon': Icons.confirmation_num_outlined,
                          'color': Color(0xFF082F61),
                          'label': "TOTAL DE RESERVAS",
                          'data': snapshot.data?['ticketsTotal'],
                          'onTap': () => Navigator.pushReplacementNamed(
                                context,
                                TicketsAdmin.routeName,
                              ),
                        },
                        {
                          'icon': Icons.devices,
                          'color': Color(0xFF274F9D),
                          'label': "TOTAL DE EQUIPAMENTOS",
                          'data': snapshot.data?['equipamentosTotal'],
                          'onTap': () => Navigator.pushReplacementNamed(
                                context,
                                Equipamentos.routeName,
                              ),
                        },
                        {
                          'icon': Icons.construction,
                          'color': Color(0xFF0462AA),
                          'label': "EQUIPAMENTOS NO CONSERTO",
                          'data': snapshot.data?['equipamentosConserto'],
                          'onTap': () => Navigator.pushReplacementNamed(
                                context,
                                Equipamentos.routeName,
                                arguments: Arguments({
                                  'status': 'EM_MANUTENCAO',
                                }),
                              ),
                        },
                        {
                          'icon': Icons.task_alt,
                          'color': Color(0xFF1480D3),
                          'label': "EQUIPAMENTOS EM USO",
                          'data': snapshot.data?['equipamentosEmUso'],
                          'onTap': () => Navigator.pushReplacementNamed(
                                context,
                                Equipamentos.routeName,
                                arguments: Arguments({
                                  'status': 'INDISPONIVEL',
                                }),
                              ),
                        },
                        {
                          'icon': Icons.event,
                          'color': Color(0xFF0090FF),
                          'label': "RESERVAS ABERTAS ESSE MÊS",
                          'data': snapshot.data?['ticketsAbertosEsseMes'],
                          'onTap': () => Navigator.pushReplacementNamed(
                                context,
                                TicketsAdmin.routeName,
                                arguments: Arguments({
                                  'dt_reserva_begin': DateTime.now().copyWith(
                                    day: 1,
                                  ),
                                  'dt_reserva_end': DateTime.now().copyWith(
                                    month: DateTime.now().month + 1,
                                    day: 0,
                                  ),
                                }),
                              ),
                        },
                      ].map(
                        (e) {
                          return Expanded(
                            child: InkWell(
                              onTap: e['onTap'] as void Function()?,
                              child: Container(
                                constraints: BoxConstraints(
                                  minHeight: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .fontSize! *
                                      2.5,
                                ),
                                margin: EdgeInsets.all(4.0),
                                padding: EdgeInsets.all(10.0),
                                color: e['color'] as Color,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          e['icon'] as IconData,
                                          size: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .fontSize!,
                                        ),
                                        Expanded(
                                          child: FittedBox(
                                            child: Text(
                                              e['label'].toString(),
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .fontSize!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      e['data']?.toString() ?? "-",
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .fontSize!,
                                      ),
                                    )
                                  ],
                                ),
                                // child: Stack(
                                //   alignment: Alignment.topLeft,
                                //   children: [
                                //     Align(
                                //       alignment: Alignment.center,
                                //       child: Text.rich(
                                //         TextSpan(
                                //           children: [
                                //             TextSpan(text: e['label'].toString()),
                                //             TextSpan(text: '\n'),
                                //             TextSpan(
                                //               text: e['value'].toString(),
                                //               style: TextStyle(
                                //                 fontSize: Theme.of(context)
                                //                     .textTheme
                                //                     .displayMedium!
                                //                     .fontSize!,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //           fontSize: Theme.of(context)
                                //               .textTheme
                                //               .titleMedium!
                                //               .fontSize!,
                                //         ),
                                //       ),
                                //     ),
                                //     Align(
                                //       alignment: Alignment.topLeft,
                                //       child: Icon(e['icon'] as IconData),
                                //     ),
                                //   ],
                                // ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
