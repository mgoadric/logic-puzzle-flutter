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
  Color bgcolor;
  Color pcolor;
  LogicPattern pattern;
  LogicShape shape;
  int x;
  int y;
  int radius;

  LogicBubble(
      {this.bgcolor = Colors.grey,
      this.pcolor = Colors.white,
      this.pattern = LogicPattern.none,
      this.shape = LogicShape.cloud,
      required this.x,
      required this.y,
      required this.radius});
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int acceptedData = 0;

  final List<Map> myProducts =
      List.generate(300, (index) => {"id": index, "name": "Product $index"})
          .toList();

  var dtarget = DragTarget<int>(
    builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Container(
        height: 100.0,
        width: 100.0,
        color: Colors.cyan,
        child: Center(
          child: Text('Value is updated to: '),
        ),
      );
    },
    onAccept: (int data) {
      //setState(() {
      //  acceptedData += data;
      //});
    },
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              height:
                  (MediaQuery.of(context).size.width - 20) * 2.0 / 2.0, //270.0,
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 50,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: myProducts.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Draggable<int>(
                      // Data is the value this Draggable stores.
                      data: myProducts[index]["id"],
                      feedback: Container(
                        color: Colors.deepOrange,
                        height: 100,
                        width: 100,
                        child: const Icon(Icons.directions_run),
                      ),
                      childWhenDragging: Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.pinkAccent,
                        child: const Center(
                          child: Text('Child When Dragging'),
                        ),
                      ),
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.lightGreenAccent,
                        child: const Center(
                          child: Text('Draggable'),
                        ),
                      ),
                    );
                  }),
            ),
            DragTarget<int>(
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.cyan,
                  child: Center(
                    child: Text('Value is updated to: $acceptedData'),
                  ),
                );
              },
              onAccept: (int data) {
                setState(() {
                  acceptedData += data;
                });
              },
            ),
          ],
        ));
  }
}
