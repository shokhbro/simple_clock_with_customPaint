import 'dart:math';

import 'package:flutter/material.dart';

class CustomClock extends CustomPainter {
  final DateTime dateTime;
  CustomClock({required this.dateTime});

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, size.height / 2);

    //! Circle 1
    var circleOne = Paint();
    circleOne.color = Colors.white;

    //! Circle 2
    var circleTwo = Paint();
    circleTwo.color = Colors.black;
    circleTwo.strokeWidth = 8;
    circleTwo.style = PaintingStyle.stroke;

    //! Circle 3
    var circleThree = Paint();
    circleThree.color = Colors.black;
    circleThree.strokeWidth = 10;

    canvas.drawCircle(center, 145, circleOne);
    canvas.drawCircle(center, 150, circleTwo);

    //! Line 1 (Hour hand)
    var lineOne = Paint();
    lineOne.color = Colors.black;
    lineOne.strokeWidth = 8;
    lineOne.strokeCap = StrokeCap.round;

    //! Line 1 (Minute hand)
    var lineTwo = Paint();
    lineTwo.color = Colors.black;
    lineTwo.strokeWidth = 6;
    lineTwo.strokeCap = StrokeCap.round;

    //! Line 1 (Second hand)
    var lineThree = Paint();
    lineThree.color = Colors.red;
    lineThree.strokeWidth = 4;
    lineThree.strokeCap = StrokeCap.round;

    var secondHandLenth = size.width / 2 * 0.85;
    var minuteHandLenth = size.width / 2 * 0.65;
    var hourHandLenth = size.width / 2 * 0.45;

    var secondAngle = (pi / 30) * dateTime.second;
    var minuteAngle =
        (pi / 30) * (dateTime.minute + (pi / 1800) * dateTime.second);
    var hourAngle =
        (pi / 6) * (dateTime.hour % 12) + (pi / 360) * dateTime.minute;

    canvas.drawLine(
      center,
      center +
          Offset(
            cos(hourAngle - pi / 2) * hourHandLenth,
            sin(hourAngle - pi / 2) * hourHandLenth,
          ),
      lineOne,
    );

    canvas.drawLine(
      center,
      center +
          Offset(
            cos(minuteAngle - pi / 2) * minuteHandLenth,
            sin(minuteAngle - pi / 2) * minuteHandLenth,
          ),
      lineTwo,
    );

    //Add numbers around the clock
    var textStyle = const TextStyle(
      fontFamily: 'Lato',
      color: Colors.black,
      fontSize: 20,
    );

    for (int i = 1; i <= 12; i++) {
      var angle = (pi / 6) * (i + 3);
      var numberX = center.dx + cos(angle - pi) * 120;
      var numberY = center.dy + sin(angle - pi) * 120;

      var textSpan = TextSpan(
        text: i.toString(),
        style: textStyle,
      );

      var textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );

      var textOffset = Offset(
        numberX - textPainter.width / 2,
        numberY - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }

    // second Angle
    canvas.drawLine(
      center,
      center +
          Offset(
            cos(secondAngle - pi / 2) * secondHandLenth,
            sin(secondAngle - pi / 2) * secondHandLenth,
          ),
      lineThree,
    );

    canvas.drawCircle(center, 15, circleThree);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
