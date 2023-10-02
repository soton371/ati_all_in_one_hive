import 'package:ati_all_in_one_hive/utilities/ampm_convert.dart';
import 'package:ati_all_in_one_hive/utilities/month_convert.dart';
import 'package:flutter/material.dart';

class MyDateWidget extends StatelessWidget {
  const MyDateWidget({super.key, required this.myDate, required this.read});
  final DateTime myDate;
  final int read;

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    TextStyle dateTextStyle = TextStyle(
      fontSize: 12,
      fontWeight: read == 0 ? FontWeight.bold : FontWeight.normal,
      color: read == 0 ? Colors.black : Colors.black.withOpacity(0.7),
    );

    if (myDate.year == currentDate.year &&
        myDate.month == currentDate.month &&
        myDate.day == currentDate.day) {
      return Text(
        "${timeConverter(hour: myDate.hour)}:${myDate.minute} ${ampmConvert(hour: myDate.hour)}",
        style: dateTextStyle,
      );
    } else if (myDate.year == currentDate.year) {
      return Text(
        "${monthConvert(month: myDate.month.toString())} ${myDate.day}",
        style: dateTextStyle,
      );
    } else {
      return Text(
        "${myDate.month}/${myDate.day}/${myDate.year}",
        style: dateTextStyle,
      );
    }
  }
}

/*
 &&
        (myDate.month == currentDate.month ||
            myDate.month != currentDate.month) &&
        (myDate.day != currentDate.day || myDate.day == currentDate.day)*/