import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'select_notification_event.dart';
part 'select_notification_state.dart';

class SelectNotificationBloc extends Bloc<SelectNotificationEvent, SelectNotificationState> {
  List<NotificationListModel> selectedNotiList = [];
  SelectNotificationBloc() : super(SelectNotificationInitial()) {
    on<CallSelectNotification>((event, emit) {
      debugPrint("CallSelectNotification");
      selectedNotiList.add(event.selectedNotification);
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });

    //for unselect 
    on<CallUnselectNotification>((event, emit) {
      debugPrint("CallUnselectNotification");
      selectedNotiList=[];
      emit(UnselectNotificationState());
    });

    //for unselect notification item
    on<CallUnselectNotificationItem>((event, emit) {
      debugPrint("CallUnselectNotificationItem");
      selectedNotiList.remove(event.selectedNotification);
      if (selectedNotiList.isEmpty) {
        emit(UnselectNotificationState());
        return;
      }
      emit(UnselectNotificationItemState(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });


    //for test
    //add for important
    on<ImportantActionEvent>((event, emit) {
      debugPrint("call ImportantActionEvent");
      for (var element in event.selectedNotifications) {element.isImportant = 1;}
      emit(ImportantActionState());
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });

    //add for not important
    on<NotImportantActionEvent>((event, emit) {
      debugPrint("call NotImportantActionEvent");
      for (var element in event.selectedNotifications) {element.isImportant = 0;}
      emit(NotImportantActionState());
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });

    //add for add favorite
    on<AddFavoriteActionEvent>((event, emit) {
      debugPrint("call FavoriteActionEvent");
      for (var element in event.selectedNotifications) {element.isFavorite = 1;}
      emit(AddFavoriteActionState());
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });

    //add for remove favorite
    on<RemoveFavoriteActionEvent>((event, emit) {
      debugPrint("call RemoveFavoriteActionEvent");
      for (var element in event.selectedNotifications) {element.isFavorite = 0;}
      emit(RemoveFavoriteActionState());
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });

    //add for read
    on<ReadActionEvent>((event, emit) {
      debugPrint("call ReadActionEvent");
      for (var element in event.selectedNotifications) {element.isRead = 1;}
      emit(ReadActionState());
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });

    //add for unread
    on<UnreadActionEvent>((event, emit) {
      debugPrint("call UnreadActionEvent");
      for (var element in event.selectedNotifications) {element.isRead = 0;}
      emit(UnreadActionState());
      emit(SelectNotificationValue(selectNotificationList: selectedNotiList, selectedCount: selectedNotiList.length));
    });
  }
}
