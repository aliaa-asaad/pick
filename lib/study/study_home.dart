import 'package:flutter/material.dart';

class SlideContainer extends StatefulWidget {
  const SlideContainer({Key? key}) : super(key: key);

  @override
  _SlideContainerState createState() => _SlideContainerState();
}

class _SlideContainerState extends State<SlideContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _offset = Tween<Offset>(begin: const Offset(1, 0.0), end: Offset(10,0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _offset,
        child: Container(
          color: Colors.cyan,
          height: 50.0,
          width: 2,
          child: const Text("hello"),
        ),
      ),
    );
  }
}
