import 'package:flutter/material.dart';
import 'package:project/modules/auth/views/auth.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/color_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0.1, end: 0.5).animate(_controller);
    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.center,
              child: TweenAnimationBuilder<double>(
                curve: Easing.standardAccelerate,
                tween: Tween<double>(begin: 300.0, end: 150.0),
                duration: const Duration(milliseconds: 1000),
                builder: (BuildContext context, double value, Widget? child) {
                  return Image.asset(
                    AppIcons.logopms,
                    fit: BoxFit.cover,
                    width: value,
                  );
                },
              ),
            ),
          ),
          
          
        ],
      ),
    );
  }
}
