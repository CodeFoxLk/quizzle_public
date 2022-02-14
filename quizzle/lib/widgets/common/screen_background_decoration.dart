import 'package:flutter/material.dart';
import 'package:quizzle/configs/configs.dart';

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration(
      {Key? key, required this.child, this.showGradient = false})
      : super(key: key);

  final Widget child;
  final bool showGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient(context) : null),
          child: CustomPaint(
            painter: BackgroundPainter(),
          ),
        )),
        Positioned.fill(child: SafeArea(child: child))
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(0.1);

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.2, 0);
    path.lineTo(0, size.height * 0.4);
    path.close();

    final path2 = Path();

    path2.moveTo(size.width, 0);
    path2.lineTo(size.width * 0.8, 0);
    path2.lineTo(size.width * 0.2, size.height);
    path2.lineTo(size.width, size.height);
    path2.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
