import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:regular_rectangle_packer/src/animated_regular_rectangle_packer.dart';
import 'package:regular_rectangle_packer/src/fixed_size_regular_rectangle_packer.dart';
import 'package:regular_rectangle_packer/src/regular_rectangle_packer.dart';
import 'package:resizable_widget/resizable_widget.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double sliderVal = 0.2;

  final int maxR = 10;
  late double rSliderValue = 0.1;
  late double r = rSliderValue * maxR;

  final int maxN = 100;
  late double nSliderValue = 0.2;
  late int n = (maxN * nSliderValue).ceil();

  late Size demoSize;
  double hAdj = 1.0;
  double vAdj = 1.0;

  late List<Widget> items = newItems;

  List<Widget> get newItems => List.generate(
      n,
      (i) => GestureDetector(
          onTap: () => key.currentState?.removeItem(i),
          child: Rectangle(r,
              child: Text('$i'),
              color: Color.lerp(Color.fromARGB(255, 255, 57, 57), Color.fromARGB(255, 2, 247, 255), i.toDouble() / n))));

  final key = GlobalKey<AnimatedRegularRectanglePackerState>();

  @override
  Widget build(BuildContext context) {
    final Widget rRlider = Slider(
      value: rSliderValue,
      onChanged: (v) {
        setState(() {
          rSliderValue = v;
          r = v * maxR;
        });
      },
    );

    final Widget nSlider = Slider(
      value: nSliderValue,
      onChanged: (v) {
        setState(() {
          nSliderValue = v;
          n = (maxN * nSliderValue).ceil();
          items = newItems;
        });
      },
    );
    final Widget hSlider = Slider(
      value: hAdj,
      onChanged: (v) {
        setState(() {
          hAdj = v;
        });
      },
    );
    final Widget vSlider = Slider(
      value: vAdj,
      onChanged: (v) {
        setState(() {
          vAdj = v;
        });
      },
    );

    final Widget content = LayoutBuilder(builder: (context, constraints) {
              
              demoSize = Size(constraints.biggest.width * hAdj,
                  constraints.biggest.height * vAdj);

              return Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.grey),
                  color: const Color.fromARGB(255, 194, 235, 255)),
                child: SizedBox.fromSize(
                  size: demoSize,
                  child: RegularRectanglePacker(
                    items: items,
                    cellRatio: r,
                  ),
                ),
              );
            });

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [

          Flexible(
            flex: 1,
              child: Container(
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Number of cells: $n'),
              nSlider,
              Text('Width to Height ratio: ${r.toStringAsFixed(3)}'),
              rRlider,
            ]),
          )),



          Flexible(
            flex: 3,
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

    Flexible(
      child: Column(
        children: [
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Flexible(child: Padding(padding: EdgeInsets.all(24.0), child: content),)
              ]),
            ),
            
                SizedBox(
                  height: 100,
                  child: hSlider,
                )
        ],
      ),
    ),


    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
              RotatedBox(quarterTurns: -1, child: vSlider,),
              Container()
      ],
    )


          ],))
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DataPoint {
  final int n;
  final double r;

  final int rowCount;
  final int colCount;

  DataPoint(this.n, this.r, this.rowCount, this.colCount);
}

class Rectangle extends StatelessWidget {
  const Rectangle(this.r, {super.key, required this.child, this.color});
  final double r;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: r,
      child: Column(children: [
        Flexible(
            child: Container(
          decoration:
              BoxDecoration(color: color ?? Colors.white, border: Border.all()),
          child: Center(child: child),
        ))
      ]),
    );
  }
}
