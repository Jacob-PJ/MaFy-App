import 'package:flutter/material.dart';
import 'dart:math';
import 'tal.dart';

class GetTriangle extends StatelessWidget {
  const GetTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();

    return Center(
      child: SizedBox(
        width: 200,
        height: 100,
        child: CustomPaint(painter: MakeTriangle()),
      ),
    );
  }
}

class MakeTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, size.height),
      paint,
    );

    final arc1 = Path();

    arc1.moveTo(25, size.height - 13);
    arc1.arcToPoint(Offset(30, size.height), radius: Radius.circular(10));

    canvas.drawPath(arc1, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: "30°",
        style: TextStyle(
            color: Colors.black, fontSize: 15, fontFamily: "semibold"),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(50, size.height - 25));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
