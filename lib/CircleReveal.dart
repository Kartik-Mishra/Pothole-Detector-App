import 'dart:math';
import 'package:flutter/material.dart';

class CircleReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;
  final Offset offset;

  const CircleReveal({Key key, this.revealPercent, this.child, this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper:
          CircleRevealClipper(revealPercent: revealPercent, offset: offset),
      child: child,
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;
  final Offset offset;
  CircleRevealClipper({this.revealPercent, this.offset});

  @override
  Rect getClip(Size size) {
    final epicenter = offset; //Offset(size.width / 2, size.height * 0.9);

    double theta = atan(epicenter.dy / epicenter.dx);
    double distanceToCorner = epicenter.dy / sin(theta);
    double radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return Rect.fromLTWH(
        epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
