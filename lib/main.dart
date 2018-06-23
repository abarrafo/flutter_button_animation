import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final List<IconData> icons = const [
    Icons.book, Icons.bookmark, Icons.keyboard_arrow_up, Icons.keyboard_arrow_down
  ];


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  AnimationController _animationController;
  bool _showMenu = false;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(),
      floatingActionButton: new SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.fromLTRB(
                0.0,
                _showMenu ? 50.0 : 0.0,
                0.0,
                0.0),
            child: new Column(
                mainAxisSize: MainAxisSize.min,
                children:
                !_showMenu ? new List()
                    : new List.generate(widget.icons.length, (int index) {
                  Widget child = new Container(
                    height: 70.0,
                    width: 56.0,
                    alignment: FractionalOffset.topCenter,
                    child: new ScaleTransition(
                      scale: new CurvedAnimation(
                        parent: _animationController,
                        curve: new Interval(
                            0.0,
                            1.0 - index / widget.icons.length / 2.0,
                            curve: Curves.easeOut
                        ),
                      ),
                      child: index == 2 || index == 3 ? new GestureDetector(
                        onDoubleTap: (){
                          //do stuff
                        },
                        onLongPress: (){
                          //do other stuff
                        },
                        child: new FloatingActionButton(
                          heroTag: index,
                          mini: true,
                          child: new Icon(widget.icons[index]),
                          onPressed: () {
                            //do other stuff
                          },
                        ),
                      ) :
                      new FloatingActionButton(
                        heroTag: index,
                        mini: true,
                        child: new Icon(widget.icons[index]),
                        onPressed: () {
                          //do stuff
                        },
                      )
                      ,
                    ),
                  );
                  return child;
                }).toList()..add(
                  new Opacity(opacity: 0.5,
                      child:  new FloatingActionButton(
                        elevation: 3.0,
                        child: new AnimatedBuilder(
                          animation: _animationController,
                          builder: (BuildContext context, Widget child) {
                            return new Transform(
                              transform: new Matrix4.rotationZ(
                                  _animationController.value * 0.5 * math.pi),
                              alignment: FractionalOffset.center,
                              child: new Icon(_animationController.isDismissed
                                  ? Icons.menu
                                  : Icons.close),
                            );
                          },
                        ),
                        onPressed: () {
                          if (_animationController.isDismissed) {
                            setState(() {
                              _showMenu = true;
                            });
                            _animationController.forward();
                          } else {
                            new Timer(new Duration(milliseconds: 500), (){
                              setState(() {
                                _showMenu = false;
                              });
                            });
                            _animationController.reverse();
                          }
                        },
                      )
                  ),
                )),
          )
      ),
    );
  }
}
