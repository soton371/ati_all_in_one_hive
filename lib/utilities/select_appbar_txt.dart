import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';

String importantTxt(
    {required List<NotificationListModel> selectNotificationList}) {
  int count = 0;

  for (var element in selectNotificationList) {
    if (element.isImportant == 1) {
      count++;
    }
  }
  if (count == selectNotificationList.length) {
    return 'Mark not important';
  } else {
    return 'Mark important';
  }
}


//add for favorite
String favoriteTxt(
    {required List<NotificationListModel> selectNotificationList}) {
  int count = 0;

  for (var element in selectNotificationList) {
    if (element.isFavorite == 1) {
      count++;
    }
  }
  if (count == selectNotificationList.length) {
    return 'Remove favorite';
  } else {
    return 'Add favorite';
  }
}