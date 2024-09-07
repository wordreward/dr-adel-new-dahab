import 'package:flutter/material.dart';


class SubAppBar extends StatelessWidget {
  const SubAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: double.infinity,
      child: CustomPaint(
          //painter: appLanguage.isEn ? EnglishPainter() : ArabicPainter()),
        )
    );
  }
}

class EnglishPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10;

    final path = Path();
    path.moveTo(size.width - 20, 0);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.circular(20));
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArabicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10;

    final path = Path();
    path.moveTo(20, 0);
    path.arcToPoint(Offset(0, size.height),
        radius: Radius.circular(20), clockwise: false);

    path.lineTo(0, 0);
    // path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
