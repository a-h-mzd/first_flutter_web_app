import 'dart:async';

import 'package:first_flutter_web_app/mini_game.dart';
import 'package:first_flutter_web_app/HomePage.dart';
import 'package:first_flutter_web_app/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.openBox('auth');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StreamController<String> _title = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Provider<StreamSink>.value(
      value: _title.sink,
      child: StreamBuilder<String>(
          stream: _title.stream,
          builder: (context, snapshot) => MaterialApp(
                key: ValueKey<String>('mainApp'),
                onGenerateTitle: (context) => snapshot.data ?? 'Web Demo',
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                themeMode: ThemeMode.dark,
                initialRoute: '/',
                routes: {
                  '/': (context) => MyHomePage(),
                  '/hive': (context) => HivePage(),
                  '/minigame': (context) => MiniGamePage(),
                },
              )),
    );
  }
}
