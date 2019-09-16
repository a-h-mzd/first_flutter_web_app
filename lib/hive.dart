import 'dart:async';
import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class HivePage extends StatefulWidget {
  @override
  HivePageState createState() => HivePageState();
}

class HivePageState extends State<HivePage> {
  Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('auth');
    Future(() => Provider.of<StreamSink>(context).add('Storage'));
  }

  @override
  void deactivate() {
    Provider.of<StreamSink>(context).add('Web Demo');
    super.deactivate();
  }

  void _onPress() async {
    Random rnd = Random();
    await box.put('key', rnd.nextInt(100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
        centerTitle: true,
      ),
      body: Center(
        child: WatchBoxBuilder(
          box: box,
          watchKeys: ['key'],
          builder: (context, box) => RaisedButton(
            child: Text('${box.get('key')}'),
            onPressed: _onPress,
            shape: StadiumBorder(),
          ),
        ),
      ),
    );
  }
}
