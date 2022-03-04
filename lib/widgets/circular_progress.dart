import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koloplan/styles/colors.dart';

class CircularProgress extends StatelessWidget {
  final double value;
  final double width;
  final Color bg;
  CircularProgress({
    this.value,
    this.bg = AppColors.kPrimaryColor,
    this.width = 40});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircularBar(
          offset: Offset(0, 0), endAngle: (pi * 2 * value), radius: 80,
          bg: bg, width: width,value: value),
    );
  }
}

class CircularBar extends CustomPainter {
  var offset = Offset(0, 0);
  var radius = 40.0;
  double width = 6;
  double value = 0;
  var endAngle = (pi * 2 * 0.5);
  Color bg = AppColors.kPrimaryColor;

  CircularBar({this.offset, this.radius, this.endAngle, this.bg, this.width, this.value});

  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint()
      ..color = bg
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset handler = degreesToCoordinates(
        Offset(0,0), -math.pi / 2  + (-math.pi+2) + endAngle + 1.5, radius);

    print("start ${-pi/2}");
    print("sweep $endAngle");
    print("handle $handler");

    Path path = Path();
    path.arcTo(Rect.fromCircle(center: offset, radius: radius), -pi / 2,
      endAngle, false);


    canvas.drawPath(path, p);
    var begginingVal = endAngle +0.05;


    print("lll ${(value*100).floor()}");
//    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius),
//        2.8530970943744053, 2.9530970943744053, false, p);

    canvas.drawCircle(position[(value*100).floor()], 1, Paint()..color = AppColors.kLightText
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke);

  }
  Offset degreesToCoordinates(Offset center, double degrees, double radius) {
    return radiansToCoordinates(center, degreeToRadians(degrees), radius);
  }
  Offset radiansToCoordinates(Offset center, double radians, double radius) {
    var dx = center.dx + radius * math.cos(radians);
    var dy = center.dy + radius * math.sin(radians);
    return Offset(dx, dy);
  }

  double degreeToRadians(double degree) {
    return (math.pi / 180) * degree;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

var position = {
  1:Offset(12,-80),
  2:Offset(17,-78),
  3:Offset(22,-76),
  4:Offset(27,-74),
  5:Offset(32,-72),
  6:Offset(37,-70),
  7:Offset(42,-68),
  8:Offset(47,-66),
  9:Offset(52,-64),
  10:Offset(52,-62),
  11:Offset(57,-60),
  12:Offset(62,-58),
  12.5:Offset(62,-52),
  13:Offset(66,-52),
  14:Offset(68,-48),
  15:Offset(70,-42),
  16:Offset(72,-38),
  17:Offset(72,-34),
  18:Offset(74,-30),
  19:Offset(77,-26),
  20:Offset(77,-22),
  21:Offset(78,-18),
  22:Offset(79,-14),
  23:Offset(80,-10),
  24:Offset(80,-5),
  25:Offset(80,0),
  26:Offset(80,5),
  27:Offset(80,10),
  28:Offset(79,14),
  29:Offset(78,18),
  30:Offset(77,22),
  31:Offset(77,26),
  32:Offset(74,34),
  33:Offset(72,38),
  34:Offset(68,42),
  35:Offset(64,44),
  36:Offset(60,46),
  37:Offset(56,54),
  38:Offset(52,58),
  39:Offset(54,60),
  40:Offset(52,64),
  41:Offset(62,80),
  42:Offset(17,78),
  43:Offset(22,76),
  44:Offset(27,74),
  45:Offset(32,72),
  46:Offset(14,78),
  47:Offset(10,78),
  48:Offset(0,78),
  49:Offset(0,78),
  50:Offset(0,80),
  51:Offset(-12,80),
  52:Offset(-17,78),
  53:Offset(-22,76),
  54:Offset(-27,74),
  55:Offset(-32,72),
  56:Offset(-37,70),
  57:Offset(-42,68),
  58:Offset(-47,66),
  59:Offset(-52,64),
  60:Offset(-52,62),
  61:Offset(-57,60),
  62:Offset(-62,58),
  63:Offset(-66,52),
  64:Offset(-68,48),
  65:Offset(-70,42),
  66:Offset(-72,38),
  67:Offset(-72,34),
  68:Offset(-74,30),
  69:Offset(-77,26),
  70:Offset(-77,22),
  71:Offset(-78,18),
  72:Offset(-79,14),
  73:Offset(-80,10),
  74:Offset(-80,5),
  62.5:Offset(-62,52),
  75:Offset(-80,0),
  76:Offset(-80,-5),
  77:Offset(-80,-10),
  78:Offset(-79,-14),
  79:Offset(-78,-18),
  80:Offset(-77,-22),
  81:Offset(-77,-26),
  82:Offset(-74,-34),
  83:Offset(-72,-38),
  84:Offset(-68,-42),
  85:Offset(-64,144),
  86:Offset(-60,-46),
  87:Offset(-56,-54),
  88:Offset(-52,-58),
  89:Offset(-54,-60),
  90:Offset(-52,-64),
  91:Offset(-62,80),
  92:Offset(-17,-78),
  93:Offset(-22,-76),
  94:Offset(-27,-74),
  95:Offset(-32,-72),
  96:Offset(-14,-78),
  97:Offset(-10,-78),
  98:Offset(0,-78),
  99:Offset(0,-78),
  100:Offset(0,-80),
};