import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_notification_event.dart';
part 'search_notification_state.dart';

class SearchNotificationBloc
    extends Bloc<SearchNotificationEvent, SearchNotificationState> {
  List<NotificationListModel> filteredNotification = [];
  SearchNotificationBloc() : super(SearchNotificationInitial()) {
    on<SearchTextChanged>((event, emit) {
      filteredNotification = event.notificationList.where((notification) {
        final lowerCaseQuery = event.query.toLowerCase();
        //only unread
        if (event.unread && !event.favorite && !event.important && !event.appWise) {
          return (notification.isRead ?? 0).isEven &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        } 
        //only favorite
        else if (!event.unread && event.favorite && !event.important && !event.appWise) {
          return (notification.isFavorite ?? 1).isOdd &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        } 
        //only important
        else if (!event.unread && !event.favorite && event.important && !event.appWise) {
          return (notification.isImportant ?? 1).isOdd &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //only appWise
        else if (!event.unread && !event.favorite && !event.important && event.appWise) {
          return notification.appName == event.selectedApp &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //2 unread & favorite 
        else if (event.unread && event.favorite && !event.important && !event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.isFavorite ?? 1).isOdd) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //2 unread & important 
        else if (event.unread && !event.favorite && event.important && !event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.isImportant ?? 1).isOdd) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //2 unread & app wise 
        else if (event.unread && !event.favorite && !event.important && event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //2 favorite & important 
        else if (!event.unread && event.favorite && event.important && !event.appWise) {
          return ((notification.isFavorite ?? 1).isOdd || (notification.isImportant ?? 1).isOdd) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //2 favorite & app wise 
        else if (!event.unread && event.favorite && !event.important && event.appWise) {
          return ((notification.isFavorite ?? 1).isOdd || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //2 important & app wise 
        else if (!event.unread && !event.favorite && event.important && event.appWise) {
          return ((notification.isImportant ?? 1).isOdd || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //3 unread, favorite & important 
        else if (event.unread && event.favorite && event.important && !event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.isFavorite ?? 1).isOdd || (notification.isImportant ?? 1).isOdd) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //3 unread, favorite & appwise 
        else if (event.unread && event.favorite && !event.important && event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.isFavorite ?? 1).isOdd || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //3 unread, important & appwise 
        else if (event.unread && !event.favorite && event.important && event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.isImportant ?? 1).isOdd || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //3 favorite, important & appwise 
        else if (!event.unread && event.favorite && event.important && event.appWise) {
          return ((notification.isFavorite ?? 1).isOdd || (notification.isImportant ?? 1).isOdd || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        //4 unread, favorite, important & appwise 
        else if (event.unread && event.favorite && event.important && event.appWise) {
          return ((notification.isRead ?? 0).isEven || (notification.isFavorite ?? 1).isOdd || (notification.isImportant ?? 1).isOdd || (notification.appName == event.selectedApp)) &&
          ((notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery));
        }
        else {
          return (notification.appName ?? '')
                .toLowerCase()
                .contains(lowerCaseQuery) ||
            (notification.title ?? '').toLowerCase().contains(lowerCaseQuery) ||
            (notification.message ?? '').toLowerCase().contains(lowerCaseQuery);
        }
        
      }).toList();

      //start sort
      if (event.sort && event.selectSort == "Newest to Oldest") {
        filteredNotification.sort((a, b) => (b.date ?? DateTime.now()).compareTo(a.date ?? DateTime.now()));
      } else if (event.sort && event.selectSort == "Oldest to Newest"){
        filteredNotification.sort((a, b) => (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
      }else if (!event.sort && event.selectSort == "Sort By"){
        filteredNotification = filteredNotification;
      }
      //end sort
      
      if (filteredNotification.isEmpty) {
        emit(NotificationSearchResultEmpty(selectApp: event.selectedApp,isAppWise: event.appWise));
        return;
      }
      
      emit(NotificationSearchResults(results: filteredNotification, unread: event.unread, favorite: event.favorite, important: event.important, sort: event.sort, selectedSort: event.selectSort, selectedApp: event.selectedApp,appWise: event.appWise));
    });
  }
}
