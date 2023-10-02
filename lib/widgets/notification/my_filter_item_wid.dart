import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:flutter/material.dart';

class MyFilterItemWidget extends StatefulWidget {
  const MyFilterItemWidget({super.key, required this.title, this.iconHas, this.isUnread, this.isFavorite, this.isImportant, this.isSort, this.isAppWise});
  final String title;
  final bool? iconHas;
  final bool? isUnread;
  final bool? isFavorite;
  final bool? isImportant;
  final bool? isSort;
  final bool? isAppWise;

  @override
  State<MyFilterItemWidget> createState() => _MyFilterItemWidgetState();
}

class _MyFilterItemWidgetState extends State<MyFilterItemWidget> {
  Color containerColor({bool unread = false, bool favorite = false, bool important = false, bool sort = false, bool appWise = false}){
    if (unread || favorite || important || sort || appWise) {
      return MyColors.seed.withOpacity(0.3);
    } else {
      return Colors.transparent;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: containerColor(favorite: widget.isFavorite ?? false,unread: widget.isUnread ?? false, important: widget.isImportant ?? false, sort: widget.isSort ?? false, appWise: widget.isAppWise ?? false),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.75)),
          ),
          widget.iconHas != null && widget.iconHas == true?
          Icon(Icons.arrow_drop_down, color: Colors.black.withOpacity(0.75))
          : const SizedBox()
        ],
      ),
    );
  }
}
