import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _totalDots = 4;
  int _currentPosition = 0;

  int _validPosition(int position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  List<String> imagePaths = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpeg',
  ];

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  String getPrettyCurrPosition() {
    return (_currentPosition + 1.0).toStringAsPrecision(3);
  }

  @override
  Widget build(BuildContext context) {
    final decorator = DotsDecorator(
      activeColor: Colors.red,
      size: Size.square(15.0),
      activeSize: Size.square(35.0),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    );

    const titleStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18.0,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dots indicator example'),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildRow([
                Text(
                  'Current position ${getPrettyCurrPosition()} / $_totalDots',
                  style: titleStyle,
                ),
              ]),
              _buildRow([
                FloatingActionButton(
                  child: const Icon(Icons.skip_previous),
                  onPressed: () {
                    _updatePosition(max(--_currentPosition, 0));
                  },
                ),
                Container(
                  width: 600,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      imagePaths as String,
                      // imagePaths[_currentPosition],
                    ),
                  ),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.skip_next),
                  onPressed: () {
                    _updatePosition(min(
                      ++_currentPosition,
                      _totalDots,
                    ));
                  },
                )
              ]),
              _buildRow([
                Column(
                  children: [
                    const SizedBox(height: 16.0),
                    DotsIndicator(
                      dotsCount: _totalDots,
                      position: _currentPosition,
                      axis: Axis.horizontal,
                      decorator: decorator,
                      onTap: (pos) {
                        setState(() => _currentPosition = pos);
                      },
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
