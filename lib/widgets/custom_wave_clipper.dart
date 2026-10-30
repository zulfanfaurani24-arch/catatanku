import 'package:flutter/material.dart';

class WaveBackgroundPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final Color color3;

  WaveBackgroundPainter({
    this.color1 = const Color(0x3334D399),
    this.color2 = const Color(0x40059669),
    this.color3 = const Color(0x2010B981),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Wave 1 - soft background layer
    final paint1 = Paint()
      ..color = color1
      ..style = PaintingStyle.fill;
    final path1 = Path();
    path1.moveTo(0, size.height * 0.72);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.65,
      size.width * 0.5,
      size.height * 0.74,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.83,
      size.width,
      size.height * 0.70,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Wave 2 - middle accent layer
    final paint2 = Paint()
      ..color = color3
      ..style = PaintingStyle.fill;
    final path2 = Path();
    path2.moveTo(0, size.height * 0.78);
    path2.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.65,
      size.height * 0.76,
    );
    path2.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.70,
      size.width,
      size.height * 0.78,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);

    // Wave 3 - foreground soft curve
    final paint3 = Paint()
      ..color = color2
      ..style = PaintingStyle.fill;
    final path3 = Path();
    path3.moveTo(0, size.height * 0.84);
    path3.quadraticBezierTo(
      size.width * 0.30,
      size.height * 0.78,
      size.width * 0.60,
      size.height * 0.86,
    );
    path3.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.92,
      size.width,
      size.height * 0.85,
    );
    path3.lineTo(size.width, size.height);
    path3.lineTo(0, size.height);
    path3.close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

