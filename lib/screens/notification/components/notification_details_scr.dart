import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:ati_all_in_one_hive/utilities/random_color.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_date_wid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({super.key, required this.notification});
  final NotificationListModel notification;

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final noti = widget.notification;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {
              if (noti.isImportant == 0) {
                          noti.isImportant = 1;
                        } else {
                          noti.isImportant = 0;
                        }
                        setState(() {
                        });
            },
            icon: noti.isImportant == 0 ? const Icon(Icons.bookmark_outline):const Icon(Icons.bookmark, color: MyColors.pink,),
          ),
          IconButton(
            onPressed: () {
              noti.isRead = 0;
              Navigator.pop(context);
              //test this
            },
            icon: const Icon(CupertinoIcons.eye_slash),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //start title
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noti.title ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (noti.isFavorite == 0) {
                          noti.isFavorite = 1;
                        } else {
                          noti.isFavorite = 0;
                        }
                        setState(() {
                        });
                      },
                      icon:noti.isFavorite == 0 ? const Icon(Icons.star_outline):const Icon(Icons.star,color: MyColors.seed,))
                ],
              ),
              //end title
              const SizedBox(
                height: 20,
              ),

              //start icon, app name, from, date & route
              Row(
                children: [
                  ClipOval(
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
                  const SizedBox(
                    width: 10,
                  ),

                  //start app name, from, date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //start app name & date
                      Row(
                        children: [
                          Text(
                            noti.appName ?? '',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          MyDateWidget(
                              myDate: noti.date ?? DateTime.now(), read: 1),
                        ],
                      ),
                      //end app name & date

                      //start from
                      Text(
                        "From ${noti.from}",
                        style: TextStyle(color: Colors.black.withOpacity(0.7)),
                      )
                      //end from
                    ],
                  ),
                  //end app name, from, & date
                  const Spacer(),
                  //start route
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.arrow_turn_up_right)),
                  //end route
                ],
              ),
              //end icon, app name, from, date & route
              const SizedBox(
                height: 30,
              ),

              //start msg
              HtmlWidget(noti.message ?? ''),
              //end msg
            ],
          ),
        ),
      ),
    );
  }
}
