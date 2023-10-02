part of 'search_notification_bloc.dart';

abstract class SearchNotificationEvent extends Equatable {
  const SearchNotificationEvent();

  @override
  List<Object> get props => [];
}

class SearchTextChanged extends SearchNotificationEvent {
  const SearchTextChanged(
      {required this.query,
      required this.notificationList,
      required this.unread,
      required this.favorite,
      required this.important,
      required this.selectSort,
      required this.sort,
      required this.appWise,
      required this.selectedApp,
      });
  final String query, selectSort, selectedApp;
  final List<NotificationListModel> notificationList;
  final bool unread, favorite, important, sort, appWise;
  // final List<AppsHubModel> selectedApps;

  @override
  List<Object> get props =>
      [query, notificationList, unread, favorite, important, selectSort,sort,appWise,selectedApp];
}
