/// initial app when you create a flutter project without comments

import 'package:video_progress_indicator_bar/progress_indicator_bar/bar_paint.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double currentProgressValue = 0;

  void _drawStraightLine() {
    setState(() {
      currentProgressValue += 10;
      debugPrint('barCurrentProgress = $currentProgressValue');
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BarPaint(
          barHeight: 30,
          currentProgressValue: currentProgressValue,
          barProgressColor: Colors.pinkAccent,
          barEndShape: StrokeCap.round,
          barLength: 200,
          barBackgroundColor: Colors.greenAccent,
          thumbRadius: 15,
          thumbColor: Colors.indigo,
          onTap: (double currentTappedValue) {
            setState(() {
              currentProgressValue = currentTappedValue;
            });
          },
          onDragStart: (double dragStartValue) {
            debugPrint('Start dragging');
          },
          onDragUpdate: (double onDragUpdateValue) {
            setState(() {
              currentProgressValue = onDragUpdateValue;
            });
          },
          onDragEnd: () {
            debugPrint('Drag end');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _drawStraightLine();
        },
      ),
    );
  }
}
