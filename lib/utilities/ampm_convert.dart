
String ampmConvert({required int hour}){
  if (hour >= 12 && hour <= 24) {
    return "PM";
  } if (hour <= 11 && hour >= 1) {
    return "AM";
  }
  else {
    return '';
  }
}

String timeConverter({required int hour}){
  if (hour > 12) {
    return "${hour - 12}";
  } else {
    return "$hour";
  }
}