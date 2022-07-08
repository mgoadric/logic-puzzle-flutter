import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("whatever"),
        ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

enum LogicShape { circle, square, triangle, cloud }

enum LogicPattern { dots, crosshatch, stripes, none }

enum LogicColor { green, yellow, red, grey }

class LogicBubble {
  final Color bgcolor;
  final Color pcolor;
  final LogicPattern pattern;
  final LogicShape shape;

  LogicBubble(
      {this.bgcolor = Colors.grey,
      this.pcolor = Colors.white,
      this.pattern = LogicPattern.none,
      this.shape = LogicShape.cloud});
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key, required this.bubble}) : super(key: key);

  final LogicBubble bubble;

  @override
  Widget build(BuildContext context) {
    BoxShape boxShape = BoxShape.circle;

    if (bubble.shape == LogicShape.square) {
      boxShape = BoxShape.rectangle;
    }

    return Draggable<LogicBubble>(
      // Data is the value this Draggable stores.
      data: bubble,

      feedback: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.pinkAccent,
        child: Center(
          child: Text('a'),
        ),
      ),
      child: Container(
        height: 100.0,
        width: 100.0,
        decoration: BoxDecoration(color: Colors.orange, shape: boxShape),
        child: Center(
          child: Text('a'),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<int> initialList = List.generate(27, (index) => index).toList();
  List<int> trueList = [];
  List<int> falseList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            DragList(myList: initialList),
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return DragList(myList: trueList);
              },
              onWillAccept: (data) {
                return !trueList.contains(data);
              },
              onAccept: (data) {
                setState(() {
                  falseList.remove(data);
                  initialList.remove(data);
                  trueList.add(data);
                });
              },
            ),
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return DragList(myList: falseList);
              },
              onWillAccept: (data) {
                return !falseList.contains(data);
              },
              onAccept: (int data) {
                setState(() {
                  trueList.remove(data);
                  initialList.remove(data);
                  falseList.add(data);
                });
              },
            ),
          ],
        ));
  }
}

class DragList extends StatefulWidget {
  DragList({required this.myList, Key? key}) : super(key: key);

  List<int> myList;

  @override
  State<DragList> createState() => _DragListState();
}

class _DragListState extends State<DragList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        height: 150,
        //(MediaQuery.of(context).size.width - 20) * 2.0 / 2.0, //270.0,
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 40,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: widget.myList.length,
            itemBuilder: (BuildContext ctx, index) {
              int x = widget.myList[index];
              return Draggable<int>(
                // Data is the value this Draggable stores.
                data: x,
                childWhenDragging: const SizedBox(
                  height: 100,
                  width: 100,
                ),
                feedback: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(
                          3.0,
                          3.0,
                        ),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                ),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: const BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle),
                  child: Center(
                    child: Text('$x'),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
