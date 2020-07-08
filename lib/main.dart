import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

//INCOMPLETE
//USE FULL SCREEN AND THAT TOO ON PC OR LAPTOP, not responsive yet
void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ScrollController scrollController, invisibleScrollController;
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset / 100;
      });
    });

    invisibleScrollController = new ScrollController();
    invisibleScrollController.addListener(() {
      if (scrollController.offset != invisibleScrollController.offset) {
        scrollController.jumpTo(invisibleScrollController.offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            child: Wrap(
              runSpacing: -2.0,
              children: <Widget>[
                TopView(scrollOffset),
                MiddleView(scrollOffset),
                SizedBox(
                  height: size.height * 2,
                  child: Stack(
                    children: <Widget>[
                      Wrap(
                        runSpacing: -2.0,
                        children: <Widget>[
                          BottomView(scrollOffset),
                          DeepestView(scrollOffset),
                        ],
                      ),
                      Transform.scale(
                        scale: scrollOffset / 10 < 1 ? 1 : scrollOffset / 10,
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 2,
                          child: Image.network(
                            "https://i.imgur.com/FzNfR85.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Image.network(
                                "https://www.vippng.com/png/full/56-564840_mountain-range-20-oct-2014-sea-floor-png.png"),
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.network("https://i.imgur.com/3wPHUXD.png",width: 100,),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:100,right: 10),
                          child: Image.network("http://pluspng.com/img-png/cartoon-sea-animals-png-bebe-mar-animal-clipart-1800.png",width: 100,),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: size.width,
                          child: Image.network(
                            "https://www.pngkey.com/png/full/382-3821261_get-involved-seabed.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: size.width / 20,
            top: size.height / 20 - scrollOffset * 100 + 100,
            child: ClipPath(
                clipper: CustomHalfCircleClipper(),
                child: MoonView(offset: scrollOffset)),
          ),
          Positioned(
            bottom: scrollOffset * 100,
            child: Container(
              height: size.height / 3,
              width: size.width,
              color: Color(0xFF003851),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: scrollOffset > 0 ? 0 : 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      child: Image.network(
                        "https://png2.cleanpng.com/sh/db8a8cc2077e869f3a2b84cc10c19589/L0KzQYm3VcI5N6lnjpH0aYP2gLBuTfFva5l0ip9sbHnzPbL5lL14cJp5fZ9qbnPrf8O0VfIxa5I1eaY5M0K5SIq1U8IyO2U1UaM6NUK6RYa7UsEzOGI3UZD5bne=/kisspng-anchor-clip-art-white-anchor-5b0ca0a4032689.3213409115275542120129.png",
                      )),
                  Text(
                    "Scroll",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: size.width / 10,
            top: size.height / 2,
            child: _submarine(scrollOffset),
          ),
          Positioned(
            right: 0,
            bottom: scrollOffset * 100 + 50,
            child: SizedBox(
              width: size.width + scrollOffset * 50,
              child: Image.network(
                  "https://www.pinclipart.com/picdir/big/373-3735270_lighthouse-clip-art.png"),
            ),
          ),
          SingleChildScrollView(
            controller: invisibleScrollController,
            child: SizedBox(
              width: size.width,
              height: size.height * 4,
            ),
          )
        ],
      ),
    );
  }

  Widget _submarine(double offset) {
    return Center(
        child: Transform.scale(
      scale: offset / 10 < 1 ? 1 : offset / 10,
      child: SizedBox(
        width: 200,
        child: Image.network(
            "https://webstockreview.net/images/submarine-clipart-15.png"),
      ),
    ));
  }
}

class MoonView extends StatefulWidget {
  final double offset;

  const MoonView({Key key, this.offset}) : super(key: key);

  @override
  _MoonViewState createState() => _MoonViewState();
}

class _MoonViewState extends State<MoonView>
    with SingleTickerProviderStateMixin {
  Widget moonCircle(double scale) {
    final radius = MediaQuery.of(context).size.width / 2;
    return Transform.scale(
      scale: scale,
      child: Container(
        width: radius,
        height: radius,
        decoration: new BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        moonCircle(1.2 - widget.offset / 10),
        moonCircle(1.0 - widget.offset / 10),
        moonCircle(0.8 - widget.offset / 10),
        moonCircle(0.6 - widget.offset / 10),
      ],
    );
  }
}

class TopView extends StatefulWidget {
  final double offset;

  TopView(this.offset);

  @override
  _TopViewState createState() => _TopViewState();
}

class _TopViewState extends State<TopView> {
  double previous = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pTemp = previous;
    previous = widget.offset;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF131862),
                const Color(0xFF87889c),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            ),
          ),
        ),
        SizedBox(
          width: size.width,
          height: size.height,
          child: Image.network(
            "https://i.imgur.com/vTHX3OX.png",
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            top: widget.offset * 40 + 100,
            left: widget.offset * 100 + (widget.offset < pTemp ? 50 : -50),
            child: Transform(
              transform: Matrix4.rotationY(widget.offset > pTemp ? 0 : pi),
              child: SizedBox(
                width: 100,
                child: Image.network(
                    "https://www.animatedimages.org/data/media/230/animated-bird-image-0239.gif"),
              ),
            )),
      ],
    );
  }
}

class MiddleView extends StatefulWidget {
  final double offset;

  MiddleView(this.offset);

  @override
  _MiddleViewState createState() => _MiddleViewState();
}

class _MiddleViewState extends State<MiddleView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF003851),
                const Color(0xFF3b89ac),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            ),
          ),
        ),
        SizedBox(
            height: size.height,
            width: size.width,
            child: Image.network(
              "https://i.imgur.com/C9Ki9ge.png",
              fit: BoxFit.fill,
            ))
      ],
    );
  }
}

class BottomView extends StatefulWidget {
  final double offset;

  BottomView(this.offset);

  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  double previous = 0.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pTemp = previous;
    previous = widget.offset;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF3b89ac),
                const Color(0xFF003851),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            ),
          ),
          child: Transform.scale(
            scale: widget.offset/50,
            child: SizedBox(
              width: 70,
              child: Image.network(
                  "https://i.imgur.com/sxTh5JE.png"),
            ),
          ),
        ),
        Positioned(
            right: widget.offset * 100 + (widget.offset > pTemp ? 50 : -50),
            child: Transform(
              transform: Matrix4.rotationY(widget.offset > pTemp ? 0 : pi),
              child: SizedBox(
                width: 100,
                child: Image.network(
                    "https://www.animatedimages.org/data/media/194/animated-fish-image-0290.gif"),
              ),
            )),
        Align(
          alignment: Alignment(0.8, 0),
          child: SizedBox(
            width: 70,
            child: Image.network(
                "https://png2.cleanpng.com/sh/5ec77b4966c85d18d932f9c9cb4ae3de/L0KzQYm3VsEyN5hsgJH0aYP2gLBuTfFvcZ5mjNdtLXbsfL60hvl0cF5qeeY2b4Kwcra0hfF1bZ8ye95ycD3kgsW0VfIybmNrfqcDOEPoc4O1V8Y1Pmc3TqY6NUK7R4i3VcQ6PWY9SZD5bne=/kisspng-animated-film-fish-eat-or-be-eaten-clip-art-5b1f2ff5883ec2.7646626415287705495581.png"),
          ),
        ),
      ],
    );
  }
}

class DeepestView extends StatefulWidget {
  final double offset;

  DeepestView(this.offset);

  @override
  _DeepestViewState createState() => _DeepestViewState();
}

class _DeepestViewState extends State<DeepestView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF003851),
                const Color(0xFF002535),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.scale(
            scale: widget.offset / 10 < 1 ? 1 : widget.offset / 17,
            child: SizedBox(
                height: size.height,
                child: Image.network("https://i.imgur.com/zYqv1kV.png")),
          ),
        )
      ],
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(-size.width, size.height / 1.7);
    path.lineTo(size.width * 2, size.height / 1.7);
    path.lineTo(size.width, -size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
