import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final title = 'Web Flutter Demo';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/hive'),
              child: Text('hive'),
              shape: StadiumBorder(),
            ),
            Container(height: 20),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/minigame'),
              child: Text('mini game'),
              shape: StadiumBorder(),
            ),
            Container(height: 20),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/randomwalk'),
              child: Text('random walk'),
              shape: StadiumBorder(),
            ),
            Container(height: 20),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/rexample'),
              child: Text('R rotation'),
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
