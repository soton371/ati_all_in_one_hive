part of 'select_notification_bloc.dart';

class SelectNotificationEvent extends Equatable {
  const SelectNotificationEvent();

  @override
  List<Object> get props => [];
}

class CallSelectNotification extends SelectNotificationEvent {
  const CallSelectNotification({required this.selectedNotification});
  final NotificationListModel selectedNotification;
  @override
  List<Object> get props => [selectedNotification];
}

class CallUnselectNotification extends SelectNotificationEvent {
}

class CallUnselectNotificationItem extends SelectNotificationEvent {
  const CallUnselectNotificationItem({required this.selectedNotification});
  final NotificationListModel selectedNotification;
  @override
  List<Object> get props => [selectedNotification];
}


//for test
class ImportantActionEvent extends SelectNotificationEvent {
  const ImportantActionEvent({required this.selectedNotifications});
  final List<NotificationListModel> selectedNotifications;
  @override
  List<Object> get props => [selectedNotifications];
}

class NotImportantActionEvent extends SelectNotificationEvent {
  const NotImportantActionEvent({required this.selectedNotifications});
  final List<NotificationListModel> selectedNotifications;
  @override
  List<Object> get props => [selectedNotifications];
}

class AddFavoriteActionEvent extends SelectNotificationEvent {
  const AddFavoriteActionEvent({required this.selectedNotifications});
  final List<NotificationListModel> selectedNotifications;
  @override
  List<Object> get props => [selectedNotifications];
}

class RemoveFavoriteActionEvent extends SelectNotificationEvent {
  const RemoveFavoriteActionEvent({required this.selectedNotifications});
  final List<NotificationListModel> selectedNotifications;
  @override
  List<Object> get props => [selectedNotifications];
}

class ReadActionEvent extends SelectNotificationEvent {
  const ReadActionEvent({required this.selectedNotifications});
  final List<NotificationListModel> selectedNotifications;
  @override
  List<Object> get props => [selectedNotifications];
}

class UnreadActionEvent extends SelectNotificationEvent {
  const UnreadActionEvent({required this.selectedNotifications});
  final List<NotificationListModel> selectedNotifications;
  @override
  List<Object> get props => [selectedNotifications];
}