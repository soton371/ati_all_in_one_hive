part of 'select_notification_bloc.dart';

abstract class SelectNotificationState extends Equatable {
  const SelectNotificationState();

  @override
  List<Object> get props => [];
}

class SelectNotificationInitial extends SelectNotificationState {}

class SelectNotificationValue extends SelectNotificationState {
  const SelectNotificationValue({required this.selectNotificationList, required this.selectedCount});
  final List<NotificationListModel> selectNotificationList;
  final int selectedCount;
  @override
  List<Object> get props => [selectNotificationList, selectedCount];
}

class UnselectNotificationState extends SelectNotificationState {
}

class UnselectNotificationItemState extends SelectNotificationState {
  const UnselectNotificationItemState({required this.selectNotificationList, required this.selectedCount});
  final List<NotificationListModel> selectNotificationList;
  final int selectedCount;
  @override
  List<Object> get props => [selectNotificationList, selectedCount];
}

//for test
class ImportantActionState extends SelectNotificationState {
}

class NotImportantActionState extends SelectNotificationState {
}

class AddFavoriteActionState extends SelectNotificationState {
}

class RemoveFavoriteActionState extends SelectNotificationState {
}

class ReadActionState extends SelectNotificationState {
}

class UnreadActionState extends SelectNotificationState {
}