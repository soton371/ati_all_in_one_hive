import 'package:ati_all_in_one_hive/blocs/notification/search_notification/search_notification_bloc.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySortSheetWidget extends StatefulWidget {
  const MySortSheetWidget({super.key, required this.query, required this.notificationList, required this.isUnread, required this.isFavorite, required this.isImportant, required this.isAppWise, required this.selectedApp, required this.selectedSort});
  final bool isUnread,isFavorite,isImportant, isAppWise;
  final String query,selectedApp,selectedSort;
  final List<NotificationListModel> notificationList;

  @override
  State<MySortSheetWidget> createState() => _MySortSheetWidgetState();
}

class _MySortSheetWidgetState extends State<MySortSheetWidget> {
  String selectSort = "Sort By";
  @override
  void initState() {
    super.initState();
    selectSort = widget.selectedSort;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.close)
            ),
          title: const Text(
            'Sort By',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          trailing: IconButton(
            onPressed: (){
              //add event
              context.read<SearchNotificationBloc>().add(
                          SearchTextChanged(
                              query: widget.query,
                              notificationList: widget.notificationList,
                              unread: widget.isUnread,
                              favorite: widget.isFavorite,
                              important: widget.isImportant,
                              selectSort: selectSort,
                              sort: selectSort == 'Sort By'? false : true,
                              appWise: widget.isAppWise,
                              selectedApp: widget.selectedApp
                              ));
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.done)
            ),
        ),
        Divider(
          color: Colors.grey.shade300,
        ),

        //start list items
        RadioListTile(
          title: const Text("Default"),
          value: "Sort By", 
          groupValue: selectSort, 
          onChanged: (value){
            setState(() {
                selectSort = value.toString();
            });
            
          },
      ),

        RadioListTile(
          title: const Text("Newest to Oldest"),
          value: "Newest to Oldest", 
          groupValue: selectSort, 
          onChanged: (value){
            setState(() {
                selectSort = value.toString();
            });
            
          },
      ),

      RadioListTile(
          title: const Text("Oldest to Newest"),
          value: "Oldest to Newest", 
          groupValue: selectSort, 
          onChanged: (value){
            setState(() {
                selectSort = value.toString();
            });
            
          },
      ),
        //end list items
      ],
    );
  }
}
