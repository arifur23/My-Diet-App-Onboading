import 'package:flutter/material.dart';

class CustomAnimation extends AnimatedWidget{
  final AnimationController animationController;

  const CustomAnimation({super.key, required this.animationController}) : super(listenable: animationController);

  Animation get animation => Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  IgnorePointer(
      child: Opacity(
        opacity: animationController.value >0 ? 1 : 0,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 20,
                right: 0,
                child: Container(
                  child: CustomPaint(
                    painter: MyPainter(Colors.blue, animation.value),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter{

  final Color color;
  final double animationValue;

  MyPainter(this.color, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
  var center = Offset(size.width - 80, 41);
  var paint = Paint()
  ..color = color
  ..style = PaintingStyle.fill;

  var radius = 1000 * animationValue;

  canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}

