import 'package:ati_all_in_one_hive/blocs/fetch_app_list/fetch_app_list_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/notification/search_notification/search_notification_bloc.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:ati_all_in_one_hive/utilities/random_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppWiseSheetWidget extends StatefulWidget {
  const MyAppWiseSheetWidget(
      {super.key,
      required this.query,
      required this.selectSort,
      required this.notificationList,
      required this.isUnread,
      required this.isFavorite,
      required this.isImportant,
      required this.isSort,
      required this.selectedApp});
  final String query, selectSort, selectedApp;
  final List<NotificationListModel> notificationList;
  final bool isUnread, isFavorite, isImportant, isSort;

  @override
  State<MyAppWiseSheetWidget> createState() => _MyAppWiseSheetWidgetState();
}

class _MyAppWiseSheetWidgetState extends State<MyAppWiseSheetWidget> {
  String selectApp = "App Wise";
  @override
  void initState() {
    super.initState();
    selectApp = widget.selectedApp;
  }
  @override
  Widget build(BuildContext context) {
    var installAppBloc = BlocProvider.of<FetchAppListBloc>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title: const Text(
            'App Wise',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: IconButton(
              onPressed: () {
                //add event
                context.read<SearchNotificationBloc>().add(SearchTextChanged(
                    query: widget.query,
                    notificationList: widget.notificationList,
                    unread: widget.isUnread,
                    favorite: widget.isFavorite,
                    important: widget.isImportant,
                    selectSort: widget.selectSort,
                    sort: widget.isSort,
                    appWise: selectApp == "App Wise" ? false : true,
                    selectedApp: selectApp));

                Navigator.pop(context);
              },
              icon: const Icon(Icons.done)),
        ),
        Divider(
          color: Colors.grey.shade300,
        ),

        const SizedBox(
          height: 15,
        ),

        RadioListTile(
          title: const Text("Default"),
          value: "App Wise",
          groupValue: selectApp,
          onChanged: (value) {
            setState(() {
              selectApp = value.toString();
            });
          },
        ),

        //start app list
        ListView.builder(
          shrinkWrap: true,
          itemCount: installAppBloc.installedAppList.length,
          itemBuilder: (context, index) {
            var data = installAppBloc.installedAppList[index];
            return RadioListTile(
              title: Row(
                children: [
                  ClipOval(
                    child: Container(
                      height: 30,
                      width: 30,
                      color: myRandomColor(),
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: "${data.img}",
                        placeholder: (context, url) =>
                            Image.asset("assets/images/android_logo.png"),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/android_logo.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${data.name}"),
                ],
              ),
              value: data.name,
              groupValue: selectApp,
              onChanged: (value) {
                setState(() {
                  selectApp = value.toString();
                });
              },
            );
          },
        )
        //end app list
      ],
    );
  }
}
