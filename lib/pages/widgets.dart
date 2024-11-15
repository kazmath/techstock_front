import 'package:flutter/material.dart';

import '../tools/utils.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({
    super.key,
    required this.child,
  });

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
            // maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
              ),
              const VerticalDivider(color: Colors.transparent),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('images/image_branca.png'),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(),
      backgroundColor: const Color(0xFFD6D6D6),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: widget.child,
      ),
    );
  }
}
