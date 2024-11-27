import 'package:flutter/material.dart';

class ThreeDotLoader extends StatefulWidget {
  @override
  _ThreeDotLoaderState createState() => _ThreeDotLoaderState();
}

class _ThreeDotLoaderState extends State<ThreeDotLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Opacity(
              opacity: _getOpacityForDot(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Dot(),
              ),
            );
          }),
        );
      },
    );
  }

  double _getOpacityForDot(int index) {
    double start = (index * 0.2) % 1.0;
    double end = start + 0.8;
    double value = _animation.value;

    if (value >= start && value <= end) {
      return 1.0;
    }
    return 0.2;
  }
}

class Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6.0,
      height: 6.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
