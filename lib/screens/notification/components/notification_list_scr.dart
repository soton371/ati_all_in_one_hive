
import 'package:ati_all_in_one_hive/blocs/notification/select_notification/select_notification_bloc.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:ati_all_in_one_hive/screens/notification/components/notification_search_scr.dart';
import 'package:ati_all_in_one_hive/widgets/my_alert_dialog.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_notification_tile.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_select_noti_appbar_wid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({super.key, required this.notifications});
  final List<NotificationListModel> notifications;

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  bool isAllRead = false;
  List<NotificationListModel> selectedNoti = [];
  @override
  Widget build(BuildContext context) {
    context.read<SelectNotificationBloc>().add(CallUnselectNotification());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: BlocBuilder<SelectNotificationBloc, SelectNotificationState>(
            builder: (context, state) {
              if (state is SelectNotificationValue) {
                return MySelectNotiAppBarWidget(
                    selectedCount: state.selectedCount,
                    selectNotificationList: state.selectNotificationList,);
              } else if (state is UnselectNotificationItemState) {
                return MySelectNotiAppBarWidget(
                    selectedCount: state.selectedCount,selectNotificationList: state.selectNotificationList,);
              } else {
                return AppBar(
                  title: const Text("Notifications"),
                  actions: [
                    //start search
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => NotificationSearchScreen(
                                      notificationList:
                                          widget.notifications))).then((value) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(CupertinoIcons.search)),
                    //end search

                    //start all mark
                    IconButton(
                        onPressed: () {
                          myAlertDialog(
                              context,
                              isAllRead
                                  ? "Mark as all unread"
                                  : "Mark as all read",
                              "Are you sure?",
                              actions: [
                                CupertinoButton(
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color:
                                              CupertinoColors.destructiveRed),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                                CupertinoButton(
                                    child: const Text("Yes"),
                                    onPressed: () {
                                      isAllRead = !isAllRead;
                                      for (var element
                                          in widget.notifications) {
                                        if (isAllRead) {
                                          element.isRead = 1;
                                        } else {
                                          element.isRead = 0;
                                        }
                                      }
                                      Navigator.pop(context);
                                      setState((){});
                                    }),
                              ]);
                        },
                        icon: Icon(isAllRead
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye)),
                    //end all mark
                  ],
                );
              }
            },
          )),
      body: ListView.builder(
          itemCount: widget.notifications.length,
          itemBuilder: (context, index) {
            NotificationListModel data = widget.notifications[index];
            return MyNotificationTile(
              notification: data,
            );
          }),
    );
  }
}
