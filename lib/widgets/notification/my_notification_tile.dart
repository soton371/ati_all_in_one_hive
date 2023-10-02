import 'package:ati_all_in_one_hive/blocs/notification/select_notification/select_notification_bloc.dart';
import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:ati_all_in_one_hive/screens/notification/components/notification_details_scr.dart';
import 'package:ati_all_in_one_hive/utilities/random_color.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_date_wid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class MyNotificationTile extends StatefulWidget {
  const MyNotificationTile(
      {super.key,
      required this.notification,
      this.forSearch = false,
      this.isUnread = false,
      this.isFavorite = false,
      this.isImportant = false});
  final NotificationListModel notification;
  final bool forSearch, isUnread, isFavorite, isImportant;

  @override
  State<MyNotificationTile> createState() => _MyNotificationTileState();
}

class _MyNotificationTileState extends State<MyNotificationTile> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    final noti = widget.notification;
    return BlocListener<SelectNotificationBloc, SelectNotificationState>(
      listener: (context, state) {
        if (state is UnselectNotificationState) {
          setState(() {
            isSelect = false;
          });
        } else if ((state is ImportantActionState ||
            state is AddFavoriteActionState ||
            state is ReadActionState ||
            state is UnreadActionState ||
            state is NotImportantActionState ||
            state is RemoveFavoriteActionState)) {
          setState(() {});
        }
      },
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => NotificationDetailsScreen(
                          notification: noti,
                        ))).then((value) {
              setState(() {});
            });
            noti.isRead = 1;
          },
          onLongPress: widget.forSearch
              ? null
              : () {
                  setState(() {
                    isSelect = !isSelect;
                  });
                  if (isSelect) {
                    debugPrint("add notification");
                    context.read<SelectNotificationBloc>().add(
                        CallSelectNotification(selectedNotification: noti));
                  } else {
                    debugPrint("remove notification");
                    context.read<SelectNotificationBloc>().add(
                        CallUnselectNotificationItem(
                            selectedNotification: noti));
                  }
                },
          child: Card(
            shadowColor: Colors.transparent,
            color: isSelect
                ? MyColors.seed.withOpacity(0.2)
                : Colors.transparent,
            surfaceTintColor:
                isSelect ? MyColors.seed : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //start icon
                  isSelect
                      ? Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: MyColors.seed),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        )
                      : ClipOval(
                          child: Container(
                            height: 40,
                            width: 40,
                            color: myRandomColor(),
                            alignment: Alignment.center,
                            child: CachedNetworkImage(
                              imageUrl: noti.appIconUrl ?? '',
                              placeholder: (context, url) => Text(
                                noti.appName.toString().substring(0, 1),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              errorWidget: (context, url, error) => Text(
                                noti.appName.toString().substring(0, 1),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                  //end icon
                  const SizedBox(
                    width: 10,
                  ),
                  //start msg
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            noti.isImportant == 1
                                ? SvgPicture.asset(
                                    "assets/images/important.svg",
                                    height: 15,
                                    width: 15,
                                  )
                                : const SizedBox(),
                            Expanded(
                              child: Text(
                                noti.appName ?? '',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: noti.isRead == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: noti.isRead == 0
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                            MyDateWidget(
                                myDate: noti.date ?? DateTime.now(),
                                read: noti.isRead ?? 0)
                          ],
                        ),
                        //start title
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                noti.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: noti.isRead == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: noti.isRead == 0
                                      ? Colors.black
                                      : Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                        //end title
                        //start msg
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 20,
                                child: HtmlWidget(
                                  noti.message ?? '',
                                  textStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            noti.isFavorite == 0
                                ? Icon(
                                    Icons.star_border,
                                    color: Colors.black.withOpacity(0.7),
                                  )
                                : const Icon(
                                    Icons.star,
                                    color: MyColors.seed,
                                  ),
                          ],
                        )
                        //start msg
                      ],
                    ),
                  ),
                  //end msg
                ],
              ),
            ),
          )),
    );
  }
}
