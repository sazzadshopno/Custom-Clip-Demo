import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 78,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    double r = 10;

    var path = Path();

    path.moveTo(0.0, 0.0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.lineTo(0, 0);

    Path rightCircle = Path()
      ..addOval(Rect.fromCircle(center: Offset(w, h / 2), radius: r))
      ..close();
    path = Path.combine(PathOperation.difference, path, rightCircle);

    Path leftCircle = Path()
      ..addOval(Rect.fromCircle(center: Offset(0, h / 2), radius: r))
      ..close();
    path = Path.combine(PathOperation.difference, path, leftCircle);

    double rectW = 10, rectH = 2.5, rectR = 10;
    double startW = 12, startH = h / 2, endW = w - 12 - rectW;
    double gap = 2;
    double inc = rectW + gap;

    for (double i = startW; i < endW; i += inc) {
      Path rect = Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(
              i,
              startH - rectH,
              rectW,
              rectH,
            ),
            Radius.circular(rectR),
          ),
        )
        ..close();
      path = Path.combine(PathOperation.difference, path, rect);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
