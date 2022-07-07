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
      home: const MyHomePage(title: 'Logic Puzzle'),
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

  draw(Canvas canvas, Size size) {
    switch (shape) {
      case LogicShape.circle:
        pattern.paintOnCircle(canvas, size, Offset(size.width - 80, 90), 50);

        // Right eye
        canvas.drawCircle(
          Offset(size.width - 80, 90),
          50,
          paint,
        );
        break;
      default:
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        color: Colors.white,
        // Inner yellow container
        child: LayoutBuilder(
          // Inner yellow container
          builder: (_, constraints) => Container(
            width: constraints.widthConstraints().maxWidth,
            height: constraints.heightConstraints().maxHeight,
            color: Colors.yellow,
            child: CustomPaint(painter: FaceOutlinePainter()),
          ),
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.indigo;

// Prepare a rectangle shape to draw the pattern on.
    final rect = RRect.fromRectAndRadius(
        const Rect.fromLTWH(20, 40, 100, 100), const Radius.circular(20));

    // Create a Pattern object of diagonal stripes with the colors we want.
    const Pattern pattern =
        Dots(bgColor: Colors.lightGreenAccent, fgColor: Colors.black);

    // Paint the pattern on the rectangle.
    pattern.paintOnRRect(canvas, size, rect);
    canvas.drawRRect(rect, paint);

    final circ = Rect.fromLTWH(size.width - 120, 40, 100, 100);

    pattern.paintOnCircle(canvas, size, Offset(size.width - 80, 90), 50);

    // Right eye
    canvas.drawCircle(
      Offset(size.width - 80, 90),
      50,
      paint,
    );
    // Mouth
    final mouth = Path();
    mouth.moveTo(size.width * 0.8, size.height * 0.6);
    mouth.arcToPoint(
      Offset(size.width * 0.2, size.height * 0.6),
      radius: Radius.circular(150),
    );
    mouth.arcToPoint(
      Offset(size.width * 0.8, size.height * 0.6),
      radius: Radius.circular(200),
      clockwise: false,
    );

    canvas.drawPath(mouth, paint);

    final path = Path();
    path.moveTo(120, 200);
    path.lineTo(300, 280);
    path.lineTo(20, 400);
    path.close();
    Crosshatch(bgColor: Colors.orange, fgColor: Colors.black)
        .paintOnPath(canvas, size, path);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
