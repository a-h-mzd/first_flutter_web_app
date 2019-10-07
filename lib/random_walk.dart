import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class RandomWalkPage extends StatefulWidget {
  RandomWalkPage({Key key}) : super(key: key);

  @override
  _RandomWalkPageState createState() => _RandomWalkPageState();
}

class _RandomWalkPageState extends State<RandomWalkPage> {
  int _sc = 0;
  int _spc = 1;
  Random _rng;
  List<charts.Color> _colors;
  List<List<_Walker>> _walkersData;
  List<charts.Series<_Walker, int>> _seriesData;

  List<List<_Walker>> _createData() {
    List<List<_Walker>> _walkers = List<List<_Walker>>();

    for (int i = 0; i < 10; i++) {
      List<_Walker> _walkerList = List<_Walker>();
      for (int j = 0; j < 101; j++) {
        int _rnd = _rng.nextInt(2) == 0 ? -1 : 1;
        _Walker _walker = _walkerList.isEmpty
            ? _Walker(j, 0)
            : _Walker(j, _walkerList[j - 1].position + _rnd);
        _walkerList.add(_walker);
      }
      _walkers.add(_walkerList);
    }
    return _walkers;
  }

  List<charts.Series<_Walker, int>> _createSeriesData() {
    List<List<_Walker>> _walkers = List<List<_Walker>>();

    for (int i = 0; i < _spc; i++) {
      List<_Walker> _walkerList = List<_Walker>();
      for (int j = 0; j <= _sc; j++) {
        _walkerList.add(_walkersData[i][j]);
      }
      _walkers.add(_walkerList);
    }

    List<charts.Series<_Walker, int>> _return =
        List<charts.Series<_Walker, int>>();

    for (int i = 0; i < _spc; i++) {
      charts.Series<_Walker, int> _value = charts.Series<_Walker, int>(
        id: '$i',
        colorFn: (_, __) => _colors[i],
        domainFn: (_Walker walker, _) => walker.step,
        measureFn: (_Walker walker, _) => walker.position,
        data: _walkers[i],
      );
      _return.add(_value);
    }

    return _return;
  }

  List<charts.Color> _colorAdder() {
    List<charts.Color> _return = List<charts.Color>();
    _return.add(charts.MaterialPalette.blue.shadeDefault);
    _return.add(charts.MaterialPalette.green.shadeDefault);
    _return.add(charts.MaterialPalette.red.shadeDefault);
    _return.add(charts.MaterialPalette.indigo.shadeDefault);
    _return.add(charts.MaterialPalette.teal.shadeDefault);
    _return.add(charts.MaterialPalette.cyan.shadeDefault);
    _return.add(charts.MaterialPalette.deepOrange.shadeDefault);
    _return.add(charts.MaterialPalette.pink.shadeDefault);
    _return.add(charts.MaterialPalette.purple.shadeDefault);
    _return.add(charts.MaterialPalette.yellow.shadeDefault);

    return _return;
  }

  @override
  void initState() {
    super.initState();

    _colors = _colorAdder();
    _rng = Random();
    _walkersData = _createData();
    _seriesData = _createSeriesData();

    Future(() => Provider.of<StreamSink>(context).add('Random Walk'));
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
        title: Text('Random Walk Example'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: _DashPatternLineChart(
                _seriesData,
                animate: true,
              ),
            ),
            Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('sample path count'),
                    NumberPicker.integer(
                      initialValue: _spc,
                      minValue: 1,
                      maxValue: 10,
                      onChanged: (num _num) {
                        setState(() {
                          _spc = _num;
                          _seriesData = _createSeriesData();
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('step count'),
                    NumberPicker.integer(
                      initialValue: _sc,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (num _num) {
                        setState(() {
                          _sc = _num;
                          _seriesData = _createSeriesData();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Walker {
  final int step;
  final int position;

  _Walker(this.step, this.position);
}

class _DashPatternLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  _DashPatternLineChart(this.seriesList, {Key key, this.animate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList, animate: animate);
  }
}
