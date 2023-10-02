import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationErrorScreen extends StatelessWidget {
  const NotificationErrorScreen({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/notification.svg",height: 80,width: 80,),
          Text("\n$message", style: const TextStyle(color: Colors.grey),),
        ],
      )),
    );
  }
}