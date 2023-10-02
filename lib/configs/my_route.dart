import 'package:flutter/cupertino.dart';

class MyRoutes {
  static void pushAndRemoveUntil(BuildContext context, myPage)=>
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_)=>myPage), (route) => false);
  static void pushReplacement(BuildContext context, myPage)=>
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_)=>myPage));
}
