
import 'package:flutter/material.dart';

class MyPainter extends StatelessWidget {
  const MyPainter({super.key, required this.height,required this.width});
  final double height,width;

  @override
  Widget build(BuildContext context) {
    
    return Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
            );
  }
}