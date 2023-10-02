import 'package:ati_all_in_one_hive/configs/my_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void myLoader(BuildContext context,String msg) {
  CupertinoAlertDialog alert= CupertinoAlertDialog(
    content: Column(
      children: [
        Text("$msg\n"),
        LinearProgressIndicator(borderRadius: BorderRadius.circular(MySizes.radius),),
      ],),
  );
  showCupertinoDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

Widget myWidgetLoader(BuildContext context){
  return Center(child: SizedBox(height: 2, width: MySizes.width(context) / 2, child: const LinearProgressIndicator()));
}