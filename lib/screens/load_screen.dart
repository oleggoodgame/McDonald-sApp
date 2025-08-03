import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mc_donalds/screens/buttomNavigation_scree.dart';

class McLoadScreen extends StatefulWidget {
  const McLoadScreen({super.key});

  @override
  State<McLoadScreen> createState() => _McLoadScreenState();
}

class _McLoadScreenState extends State<McLoadScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _imageController;
  late Animation<double> _progressAnimation;
  late Animation<double> _textPositionAnimation;
  late Animation<double> _rotationAnimation;

  late int _loadingDuration;

  @override
  void initState() {
    super.initState();

    _loadingDuration = Random().nextInt(4) + 2;

    _progressController = AnimationController(
      //Цей контролер відповідає за анімацію лінії завантаження (LinearProgressIndicator
      vsync: this,
      duration: Duration(seconds: _loadingDuration),
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_progressController);
    //Це звичайна лінійна анімація від 0 до 1, яка передається в LinearProgressIndicator.value.
    //Тобто ми просто бачимо, як повільно заливається жовта смужка.
    _progressController.forward();

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _textPositionAnimation = Tween<double>(begin: -100, end: 0).animate(
      //Початок: -100 (тобто далеко над екраном)
      CurvedAnimation(parent: _imageController, curve: Curves.easeOut),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _imageController, curve: Curves.easeOut));

    _imageController.forward();

    Timer(Duration(seconds: _loadingDuration), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ButtomnavigationScreen()),//створює новий екран, який можна замінити замість поточного
      );
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),

            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: AnimatedBuilder(
                animation: _imageController,
                builder: (context, child) {
                  // / переміщення вниз
                  return Transform.translate(
                    offset: Offset(0, _textPositionAnimation.value),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(
                        _rotationAnimation.value,
                      ), // // обертання
                      child: Image.asset("assets/images/McDonald's.png"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AnimatedBuilder(
                animation: _progressAnimation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressAnimation.value,
                    color: Colors.yellow[700],
                    backgroundColor: Colors.grey[300],
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
