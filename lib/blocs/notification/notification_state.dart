part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  
  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationFetchedState extends NotificationState {
  final List<NotificationListModel> notificationList;
  const NotificationFetchedState({required this.notificationList});
  @override
  List<Object> get props => [notificationList];
}

class NotificationFailedState extends NotificationState {
  final String errorMsg;
  const NotificationFailedState({required this.errorMsg});
  
  @override
  List<Object> get props => [errorMsg];
}
