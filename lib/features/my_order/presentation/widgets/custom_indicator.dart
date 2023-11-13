import 'package:flutter/material.dart';
import 'package:pick_up/utilities/media_quary.dart';

class CustomTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double tabBarIndicatorSize;
  final double tabBarIndicatorRadius;

  const CustomTabIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
    required this.tabBarIndicatorSize,
    required this.tabBarIndicatorRadius,
  });

  @override
  CustomPainter createBoxPainter([VoidCallback? onChanged]) {
    return CustomPainter(
      indicatorHeight: indicatorHeight,
      indicatorColor: indicatorColor,
      tabBarIndicatorSize: tabBarIndicatorSize,
      tabBarIndicatorRadius: tabBarIndicatorRadius,
      onChange: onChanged,
    );
  }
}

class CustomPainter extends BoxPainter {
  final double indicatorHeight;
  final Color indicatorColor;
  final double tabBarIndicatorSize;
  final double tabBarIndicatorRadius;

  CustomPainter({
    required this.indicatorHeight,
    required this.indicatorColor,
    required this.tabBarIndicatorSize,
    required this.tabBarIndicatorRadius,
    VoidCallback? onChange,
  }) : super(onChange);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = Offset(offset.dx + MediaQueryHelper.height * .02,
            offset.dy + configuration.size!.height - indicatorHeight) &
        Size(configuration.size!.width * .75, indicatorHeight);
    final Paint paint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: Radius.circular(tabBarIndicatorRadius),
          topRight: Radius.circular(tabBarIndicatorRadius),
        ),
        paint);
  }
}
