import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RExample extends StatefulWidget {
  @override
  _RExampleState createState() => _RExampleState();
}

class _RExampleState extends State<RExample> {
  @override
  void initState() {
    super.initState();
    Future(() => Provider.of<StreamSink>(context).add('R file download'));
  }

  @override
  void deactivate() {
    Provider.of<StreamSink>(context).add('Web Demo');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Press the button'),
        centerTitle: true,
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.file_download),
          onPressed: () => null,
          tooltip: 'download',
        ),
      ),
    );
  }
}
