import 'package:ati_all_in_one_hive/blocs/notification/select_notification/select_notification_bloc.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:ati_all_in_one_hive/utilities/select_appbar_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySelectNotiAppBarWidget extends StatelessWidget {
  const MySelectNotiAppBarWidget(
      {super.key,
      required this.selectedCount,
      required this.selectNotificationList});
  final int selectedCount;
  final List<NotificationListModel> selectNotificationList;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      leading: IconButton(
          onPressed: () {
            context
                .read<SelectNotificationBloc>()
                .add(CallUnselectNotification());
          },
          icon: const Icon(Icons.arrow_back)),
      title: Text("$selectedCount selected"),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 'Mark important':
                context.read<SelectNotificationBloc>().add(ImportantActionEvent(
                    selectedNotifications: selectNotificationList));
                break;
              case 'Mark not important':
                context.read<SelectNotificationBloc>().add(NotImportantActionEvent(
                    selectedNotifications: selectNotificationList));
                break;
              case 'Add favorite':
                context.read<SelectNotificationBloc>().add(AddFavoriteActionEvent(
                    selectedNotifications: selectNotificationList));
                break;
              case 'Remove favorite':
                context.read<SelectNotificationBloc>().add(RemoveFavoriteActionEvent(
                    selectedNotifications: selectNotificationList));
                break;
              case 'Read':
                context.read<SelectNotificationBloc>().add(ReadActionEvent(
                    selectedNotifications: selectNotificationList));
                break;
              case 'Unread':
                context.read<SelectNotificationBloc>().add(UnreadActionEvent(
                    selectedNotifications: selectNotificationList));
                break;
              default:
            }
          },
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                value: importantTxt(selectNotificationList: selectNotificationList),
                child: Row(
                  children: [
                    const Icon(
                      Icons.bookmark_outline,
                      size: 18,
                    ),
                    Text("  ${importantTxt(selectNotificationList: selectNotificationList)}"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: favoriteTxt(selectNotificationList: selectNotificationList),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      size: 18,
                    ),
                    Text("  ${favoriteTxt(selectNotificationList: selectNotificationList)}"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Read',
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 18,
                    ),
                    Text("  Read"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Unread',
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility_off_outlined,
                      size: 18,
                    ),
                    Text("  Unread"),
                  ],
                ),
              ),
            ];
          },
        )
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            height: .5,
            width: double.maxFinite,
            color: Colors.grey.shade300,
          )),
    );
  }
}
