import 'package:ati_all_in_one_hive/configs/my_sizes.dart';
import 'package:ati_all_in_one_hive/db/app_store_db.dart';
import 'package:ati_all_in_one_hive/models/app_store_mod.dart';
import 'package:ati_all_in_one_hive/screens/dashboard/components/build_item.dart';
import 'package:ati_all_in_one_hive/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ReorderableItems extends StatefulWidget {
  const ReorderableItems(this.getAppList, {super.key});

  final List<AppStoreModel> getAppList;

  @override
  State<ReorderableItems> createState() => _ReorderableItemsState();
}

class _ReorderableItemsState extends State<ReorderableItems> {

  @override
  Widget build(BuildContext context) {
    return ReorderableGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      //for drag design
      dragWidgetBuilder: (index, child) {
        return child;
      },
      //end drag design
      padding: const EdgeInsets.all(MySizes.bodyPadding),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: Responsive.isMobile(context)
          ? 2
          : Responsive.isTablet(context)
              ? 3
              : 4,
      children: widget.getAppList
          .map((e) => Card(
              key: ValueKey(e.appId),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: BuildItem("${e.name}", '${e.appId}', '${e.img}', '${e.url}', '${e.appInstalled}')))
          .toList(),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          final element = widget.getAppList.removeAt(oldIndex);
          widget.getAppList.insert(newIndex, element);
        });

        //for store data after new sort
        int appOrder = 1;
        for (var data in widget.getAppList) {
          final element = AppStoreModel(appOrder: appOrder, name: data.name, appId: data.appId, img: data.img, appInstalled: data.appInstalled);
          AppStoreDb.updateAppStoreModel(element);
          appOrder++;
        }
        //end store data after new sort
      },
    );
  }
}
