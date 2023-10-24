import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ConfirmContent extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? card;

  const ConfirmContent(
      {super.key, required this.title, this.content, this.card});

  @override
  Widget build(BuildContext context) {
    Offset offset1 = const Offset(0, 0);
    Offset offset2 = const Offset(0, 0);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0.r),
          child: Row(
            children: [
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints box) {
                RenderBox? renderBox = context.findRenderObject() as RenderBox;
                offset1 = renderBox.localToGlobal(Offset.zero);
                log(offset1.toString());
                return CircleAvatar(
                  radius: 6.r,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  // child: Icon(Icons.check),
                );
              }),
              SizedBox(
                width: MediaQueryHelper.width * .03,
              ),
              Text(
                title,
                style: TextStyleHelper.subtitle20,
              ),
            ],
          ),
        ),
        Container(
            height: offset2.dy - offset1.dy,
            width: 20,
            color: Colors.green,
            ),

        /*  Container(
          color:Colors.green,
          
          child: CustomPaint(
            size: Size(200,100),
            painter: MyPainter()
              ..start = offset1
              ..end = offset2
              ,

          //  size: const Size(51, 10),
          ),
        ), */
        Padding(
          padding: EdgeInsets.only(bottom: 8.0.r),
          child: Row(
            children: [
              LayoutBuilder(builder: (context, box) {
                RenderBox? renderBox = context.findRenderObject() as RenderBox;
                offset2 = renderBox.localToGlobal(Offset.zero);
                log(offset2.toString());
                return CircleAvatar(
                  radius: 6.r,
                  backgroundColor: const Color(0xff4F5E7B),
                );
              }),
              SizedBox(
                width: MediaQueryHelper.width * .03,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    /* border: Border.all(color: Colors.grey), */
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: card ??
                      Text(
                        content!,
                      ),
                ),
              )
            ],
          ),
        ),
        Container(
            height: offset2.dy - offset1.dy,
            width: 20,
            color: Colors.green,
            ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  Offset start = const Offset(0, 0);
  Offset end = const Offset(0, 0);
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    return Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class LinePainter extends CustomPainter {
  Offset? start;
  Offset? end;
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 15
      ..colorFilter = const ColorFilter.mode(Colors.black, BlendMode.srcOver);

    Offset start1 = start!;
    Offset end1 = end!;

    canvas.drawLine(start1, end1, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyPainter extends CustomPainter {
  Offset? start;
  Offset? end;
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(start!.dx, start!.dy);
    path.lineTo(end!.dx, end!.dy);

    var paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.black;
    paint.strokeWidth = 4.0;
    paint.blendMode = BlendMode.srcOver;
    paint.colorFilter = const ColorFilter.mode(Colors.black, BlendMode.srcOver);
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
