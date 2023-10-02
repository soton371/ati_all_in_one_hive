import 'package:ati_all_in_one_hive/blocs/notification/search_notification/search_notification_bloc.dart';
import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_appwise_sheet_wid.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_filter_item_wid.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_notification_tile.dart';
import 'package:ati_all_in_one_hive/widgets/notification/my_sort_sheet_wid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationSearchScreen extends StatefulWidget {
  const NotificationSearchScreen({super.key, required this.notificationList});
  final List<NotificationListModel> notificationList;

  @override
  State<NotificationSearchScreen> createState() =>
      _NotificationSearchScreenState();
}

class _NotificationSearchScreenState extends State<NotificationSearchScreen> {
  String query = '';
  TextEditingController queryController = TextEditingController();
  bool isUnread = false;
  bool isFavorite = false;
  bool isImportant = false;
  bool isSort = false;
  String selectSort = "Sort By";
  bool isAppWise = false;
  String selectedApps = "App Wise";
  @override
  void initState() {
    super.initState();
    context.read<SearchNotificationBloc>().add(SearchTextChanged(
        query: query,
        notificationList: widget.notificationList,
        unread: isUnread,
        favorite: isFavorite,
        important: isImportant,
        selectSort: selectSort,
        sort: isSort,
        appWise: isAppWise,
        selectedApp: selectedApps));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: TextField(
          controller: queryController,
          onChanged: (value) {
            query = value;
            context.read<SearchNotificationBloc>().add(SearchTextChanged(
                query: query,
                notificationList: widget.notificationList,
                unread: isUnread,
                favorite: isFavorite,
                important: isImportant,
                selectSort: selectSort,
                sort: isSort,
                appWise: isAppWise,
                selectedApp: selectedApps));
            debugPrint("query: $query");
            setState(() {});
          },
          decoration: InputDecoration(
              hintText: "Search in notification",
              border: InputBorder.none,
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        query = '';
                        queryController = TextEditingController(text: query);
                        context.read<SearchNotificationBloc>().add(
                            SearchTextChanged(
                                query: query,
                                notificationList: widget.notificationList,
                                unread: isUnread,
                                favorite: isFavorite,
                                important: isImportant,
                                selectSort: selectSort,
                                sort: isSort,
                                appWise: isAppWise,
                                selectedApp: selectedApps));
                        setState(() {});
                      },
                      icon: const Icon(Icons.close))),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2),
            child: Container(
              height: .5,
              width: double.maxFinite,
              color: Colors.grey.shade300,
            )),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          //start list for filter
          SizedBox(
            height: 30,
            width: double.maxFinite,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 10,
                ),
                //start unread
                InkWell(
                    onTap: () {
                      query = '';
                      queryController = TextEditingController(text: query);
                      isUnread = !isUnread;
                      context.read<SearchNotificationBloc>().add(
                          SearchTextChanged(
                              query: query,
                              notificationList: widget.notificationList,
                              unread: isUnread,
                              favorite: isFavorite,
                              important: isImportant,
                              selectSort: selectSort,
                              sort: isSort,
                              appWise: isAppWise,
                              selectedApp: selectedApps));
                      setState(() {});
                    },
                    child: MyFilterItemWidget(
                      title: "Unread",
                      isUnread: isUnread,
                    )),
                //end unread

                //start app wise
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        context: context,
                        builder: (context) => MyAppWiseSheetWidget(
                              query: query,
                              selectSort: selectSort,
                              notificationList: widget.notificationList,
                              isUnread: isUnread,
                              isFavorite: isFavorite,
                              isImportant: isImportant,
                              isSort: isSort,
                              selectedApp: selectedApps,
                            ));
                  },
                  child: BlocBuilder<SearchNotificationBloc,
                      SearchNotificationState>(
                    builder: (context, state) {
                      if (state is NotificationSearchResults) {
                        selectedApps = state.selectedApp;
                        isAppWise = state.appWise;
                        return MyFilterItemWidget(
                          title: selectedApps,
                          iconHas: true,
                          isAppWise: isAppWise,
                        );
                      } else if (state is NotificationSearchResultEmpty) {
                        selectedApps = state.selectApp;
                        isAppWise = state.isAppWise;
                        return MyFilterItemWidget(
                          title: selectedApps,
                          iconHas: true,
                          isSort: isAppWise,
                        );
                      } else {
                        selectedApps = "App Wise";
                        isAppWise = false;
                        return MyFilterItemWidget(
                          title: selectedApps,
                          iconHas: true,
                          isAppWise: isAppWise,
                        );
                      }
                    },
                  ),
                ),
                //end app wise

                //start favorite
                InkWell(
                    onTap: () {
                      query = '';
                      queryController = TextEditingController(text: query);
                      isFavorite = !isFavorite;
                      context.read<SearchNotificationBloc>().add(
                          SearchTextChanged(
                              query: query,
                              notificationList: widget.notificationList,
                              unread: isUnread,
                              favorite: isFavorite,
                              important: isImportant,
                              selectSort: selectSort,
                              sort: isSort,
                              appWise: isAppWise,
                              selectedApp: selectedApps));
                      setState(() {});
                    },
                    child: MyFilterItemWidget(
                      title: "Favorite",
                      isFavorite: isFavorite,
                    )),
                //end favorite

                //start Important
                InkWell(
                    onTap: () {
                      query = '';
                      queryController = TextEditingController(text: query);
                      isImportant = !isImportant;
                      context.read<SearchNotificationBloc>().add(
                          SearchTextChanged(
                              query: query,
                              notificationList: widget.notificationList,
                              unread: isUnread,
                              favorite: isFavorite,
                              important: isImportant,
                              selectSort: selectSort,
                              sort: isSort,
                              appWise: isAppWise,
                              selectedApp: selectedApps));
                      setState(() {});
                    },
                    child: MyFilterItemWidget(
                      title: "Important",
                      isImportant: isImportant,
                    )),
                //end Important

                //start sort
                InkWell(onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => MySortSheetWidget(
                            query: query,
                            notificationList: widget.notificationList,
                            isUnread: isUnread,
                            isFavorite: isFavorite,
                            isImportant: isImportant,
                            isAppWise: isAppWise,
                            selectedApp: selectedApps,
                            selectedSort: selectSort,
                          ));
                }, child: BlocBuilder<SearchNotificationBloc,
                    SearchNotificationState>(
                  builder: (context, state) {
                    if (state is NotificationSearchResults) {
                      selectSort = state.selectedSort;
                      isSort = state.sort;
                      return MyFilterItemWidget(
                        title: selectSort,
                        iconHas: true,
                        isSort: isSort,
                      );
                    } else {
                      selectSort = "Sort By";
                      isSort = false;
                      return MyFilterItemWidget(
                        title: selectSort,
                        iconHas: true,
                        isSort: isSort,
                      );
                    }
                  },
                )),
                //end sort

                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          //end list for filter
          const SizedBox(
            height: 15,
          ),

          //start search for notification show
          query.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.manage_search,
                      color: Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '''Search for "$query" in notification''',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
          //end search for notification show
          const SizedBox(
            height: 15,
          ),

          //start search notification list
          Expanded(
            child: BlocBuilder<SearchNotificationBloc, SearchNotificationState>(
              builder: (context, state) {
                if (state is NotificationSearchResults) {
                  return ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        final data = state.results[index];
                        return MyNotificationTile(
                          notification: data,
                          forSearch: true,
                          isUnread: isUnread,
                          isFavorite: isFavorite,
                          isImportant: isImportant,
                        );
                      });
                } else if (state is NotificationSearchResultEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/search.png",
                        height: 80,
                        width: 80,
                      ),
                      query.isEmpty
                          ? const Text(
                              '''\nNo results found''',
                              style: TextStyle(color: Colors.grey),
                            )
                          : Text(
                              '''\nNo matches for "$query"''',
                              style: const TextStyle(color: Colors.grey),
                            ),
                    ],
                  ));
                } else {
                  return ListView.builder(
                      itemCount: widget.notificationList.length,
                      itemBuilder: (context, index) {
                        final data = widget.notificationList[index];
                        return MyNotificationTile(
                          notification: data,
                          forSearch: true,
                        );
                      });
                }
              },
            ),
          ),
          //end search notification list
        ],
      ),
    );
  }
}
