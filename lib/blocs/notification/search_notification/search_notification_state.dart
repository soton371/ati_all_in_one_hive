part of 'search_notification_bloc.dart';

abstract class SearchNotificationState extends Equatable {
  const SearchNotificationState();

  @override
  List<Object> get props => [];
}

class SearchNotificationInitial extends SearchNotificationState {}

class NotificationSearchResults extends SearchNotificationState {
  const NotificationSearchResults(
      {required this.results,
      required this.unread,
      required this.favorite,
      required this.important,
      required this.sort,
      required this.selectedSort,
      required this.appWise,
      required this.selectedApp
      });
  final List<NotificationListModel> results;
  final bool unread, favorite, important, sort, appWise;
  final String selectedSort,selectedApp;

  @override
  List<Object> get props => [results, selectedSort, sort, appWise, selectedApp];
}

class NotificationSearchResultEmpty extends SearchNotificationState {
  const NotificationSearchResultEmpty({required this.selectApp, required this.isAppWise});
  final String selectApp;
  final bool isAppWise;
  @override
  List<Object> get props => [selectApp,isAppWise];
}
