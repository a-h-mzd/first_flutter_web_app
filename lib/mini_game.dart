import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiniGamePage extends StatefulWidget {
  @override
  _MiniGamePageState createState() => _MiniGamePageState();
}

class _MiniGamePageState extends State<MiniGamePage> {
  bool _acceptedBlue = false;
  bool _acceptedRed = false;

  @override
  void initState() {
    super.initState();
    Future(() => Provider.of<StreamSink>(context).add('Mini Game'));
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
        title: Text('Let\'s Play!'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Draggable<Color>(
                  data: Colors.blueAccent,
                  child: Container(
                    width: 200,
                    height: 200,
                    child:
                        _acceptedBlue ? Center(child: Text('well done')) : null,
                    color:
                        _acceptedBlue ? Colors.transparent : Colors.blueAccent,
                  ),
                  childWhenDragging: Container(
                    width: 200,
                    height: 200,
                    color: Colors.transparent,
                  ),
                  feedback: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle),
                  ),
                  maxSimultaneousDrags: _acceptedBlue ? 0 : 1,
                ),
                Draggable<Color>(
                  data: Colors.redAccent,
                  child: Container(
                    width: 200,
                    height: 200,
                    child:
                        _acceptedRed ? Center(child: Text('well done')) : null,
                    color: _acceptedRed ? Colors.transparent : Colors.redAccent,
                  ),
                  childWhenDragging: Container(
                    width: 200,
                    height: 200,
                    color: Colors.transparent,
                  ),
                  feedback: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle),
                  ),
                  maxSimultaneousDrags: _acceptedRed ? 0 : 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DragTarget<Color>(
                  onWillAccept: (c) => c == Colors.blueAccent,
                  onAccept: (c) => setState(() => _acceptedBlue = true),
                  builder: (context, incoming, rejected) {
                    return _acceptedBlue
                        ? Container(
                            width: 200,
                            height: 200,
                            color: Colors.blueAccent,
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            child: Center(child: Text('drag here')),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle),
                          );
                  },
                ),
                DragTarget<Color>(
                  onWillAccept: (c) => c == Colors.redAccent,
                  onAccept: (c) => setState(() => _acceptedRed = true),
                  builder: (context, incoming, rejected) {
                    return _acceptedRed
                        ? Container(
                            width: 200, height: 200, color: Colors.redAccent)
                        : Container(
                            width: 200,
                            height: 200,
                            child: Center(child: Text('drag here')),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                                shape: BoxShape.rectangle),
                          );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        tooltip: 'restart',
        onPressed: () => setState(() {
          _acceptedBlue = false;
          _acceptedRed = false;
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
