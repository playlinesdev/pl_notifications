import 'package:flutter/material.dart';

class PlNotificationContainer extends StatefulWidget {
  final double width, height;
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Function onEnd;

  PlNotificationContainer(
    this.child,
    this.duration, {
    this.curve = Curves.ease,
    this.width = 1,
    this.height = 1,
    this.onEnd,
  });

  @override
  _PlNotificationContainerState createState() =>
      _PlNotificationContainerState();
}

class _PlNotificationContainerState extends State<PlNotificationContainer> {
  double width, height;
  Color color;
  int alpha;
  Widget child;
  Duration duration;
  Curve curve;
  Function onEnd;

  double alphaSkew = 0.1, betaSkew = 0.9;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    curve = widget.curve;
    width = widget?.width / 2;
    height = widget?.height / 2;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        child = widget.child;
        onEnd = widget.onEnd;
        width = widget.width;
        height = widget.height;
        alphaSkew = 0;
        betaSkew = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedContainer(
          onEnd: onEnd,
          width: width,
          height: height,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              if (child != null) child,
            ],
          ),
          curve: curve,
          transform: Matrix4.skew(alphaSkew, betaSkew),
          duration: duration,
        ),
      ),
    );
  }
}
