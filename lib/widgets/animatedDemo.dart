import 'package:flutter/material.dart';

class AnimatedDemoStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedStateful();
  }
}

class AnimatedStateful extends StatefulWidget {
  AnimatedStateful({Key key}) : super();

  @override
  AnimatedState createState() => AnimatedState();
}

//class AnimatedState extends State<AnimatedStateful> {
//  double width = 100.0, height = 100.0;
//  Offset position ;
//
//  @override
//  void initState() {
//    super.initState();
//    position = Offset(0.0, height - 20);
//  }
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Stack(
//      children: <Widget>[
//        Positioned(
//          left: position.dx,
//          top: position.dy - height + 20,
//          child: Draggable(
//            childWhenDragging: Container(),
//            child: Container(
//              width: width,
//              height: height,
//              color: Colors.blue,
//              child: Center(child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
//            ),
//            feedback: Container(
//              child: Center(
//                child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
//              color: Colors.blue[300],
//              width: width,
//              height: height,
//            ),
//            onDraggableCanceled: (Velocity velocity, Offset offset){
//              setState(() => position = offset);
//            },
//          ),
//        ),
//      ],
//    );
//  }
//}

class AnimatedState extends State<AnimatedStateful>
    with SingleTickerProviderStateMixin {
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];
  AnimationController _controller;
  Duration duration = new Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: this.duration,
    );
  }

  @override
  void didUpdateWidget(AnimatedStateful oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.duration = this.duration;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: GestureDetector(
            child: BottomSheet(
                animationController: _controller,
                onClosing: () {
                  print("Closed");
                },
                enableDrag: true,
                builder: (context) {
                  return Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(color: Colors.yellow),
                    child: Center(child: Text("Drag me")),
                  );
                }),
            onHorizontalDragUpdate: (e) => {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                              'This is the modal bottom sheet. Tap anywhere to dismiss.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        );
                      })
                },
          ),
        ));
  }
}
