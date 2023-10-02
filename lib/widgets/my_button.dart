import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [
                                Colors.deepPurple,
                                Colors.deepPurpleAccent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.purple,
                          onTap: onPressed,
                          child: Center(
                            child: Text(
                              text,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
  }
}
