// 1

import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgress extends StatefulWidget {
  CircularProgress(
      {@required this.size, this.secondaryColor = Colors.white, this.primaryColor = Colors.orange, this.lapDuration = 1000, this.strokeWidth = 5.0});
// 2
  final double size;
  final Color secondaryColor;
  final Color primaryColor;
  final int lapDuration;
  final double strokeWidth;

  @override
  _CircularProgress createState() => _CircularProgress();
}

// 3
class _CircularProgress extends State<CircularProgress> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePaint(secondaryColor: widget.secondaryColor, primaryColor: widget.primaryColor, strokeWidth: widget.strokeWidth),
      size: Size(widget.size, widget.size),
    );
  }
}

class CirclePaint extends CustomPainter {
  final Color secondaryColor;
  final Color primaryColor;
  final double strokeWidth;

  double _degreeToRad(double degree) => degree * math.pi / 180;

  CirclePaint({this.secondaryColor = Colors.grey, this.primaryColor = Colors.blue, this.strokeWidth = 15});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    double startAngle = _degreeToRad(270);
    double sweepAngle = _degreeToRad(90);

    double bottomRectSideSize = (size.width / (2 * math.sqrt(2))) * 0.9;

    var path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height);

    path.addArc(Rect.fromLTRB(size.width * -0.5, size.height / 2, size.width / 2, size.height * 1.5), startAngle, sweepAngle);

    canvas.drawPath(path, paint);

    canvas.drawRect(Offset(0.0, size.height - bottomRectSideSize) & Size(bottomRectSideSize, bottomRectSideSize), paint);

    // canvas.drawArc(Offset(0.0, 0.0) & Size(size.width, size.width), startAngle, sweepAngle, false, paint..color = primaryColor);
  }

  @override
  bool shouldRepaint(CirclePaint oldDelegate) {
    return true;
  }
}
