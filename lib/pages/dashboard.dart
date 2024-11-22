// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:techstock_front/pages/equipamento_db.dart';
import 'package:techstock_front/pages/ticket_admin_db.dart';
import 'package:techstock_front/pages/widgets.dart';
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
      child: Padding(
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
                      'label': "TOTAL DE TICKETS",
                      'future': Future.value("190"),
                      'onTap': () => Navigator.pushNamed(
                            context,
                            TicketsAdmin.routeName,
                          ),
                    },
                    {
                      'icon': Icons.devices,
                      'color': Color(0xFF274F9D),
                      'label': "TOTAL DE EQUIPAMENTOS",
                      'future': Future.value("80"),
                      'onTap': () => Navigator.pushNamed(
                            context,
                            Equipamentos.routeName,
                          ),
                    },
                    {
                      'icon': Icons.construction,
                      'color': Color(0xFF0462AA),
                      'label': "EQUIPAMENTOS NO CONSERTO",
                      'future': Future.value("2"),
                      'onTap': null,
                    },
                    {
                      'icon': Icons.task_alt,
                      'color': Color(0xFF1480D3),
                      'label': "EQUIPAMENTOS EM USO",
                      'future': Future.value("5"),
                      'onTap': null,
                    },
                    {
                      'icon': Icons.event,
                      'color': Color(0xFF0090FF),
                      'label': "TICKETS ABERTOS ESSE MÊS",
                      'future': Future.value("20"),
                      'onTap': null,
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
                                FutureBuilder(
                                  future: e['future'] as Future<String>?,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? "-",
                                      style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .fontSize!,
                                      ),
                                    );
                                  },
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
      ),
    );
  }
}
