import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/configs/my_route.dart';
import 'package:ati_all_in_one_hive/db/auth_db.dart';
import 'package:ati_all_in_one_hive/screens/auth/login_scr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? userName;

  Future<void> userInfo() async {
    userName = await AuthDb.fetchUserInfo();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    userInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          //for avatar
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: CircleAvatar(
              radius: 35,
              child: SvgPicture.asset('assets/images/user.svg'),
            ),
          ),
          //end avatar

          //start name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              userName ?? 'Soton Ahmed',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontFamily: "Pacifico"),
            ),
          ),
          //end name

          const SizedBox(
            height: 30,
          ),

          //for list items
          ListTile(
            onTap: () => Navigator.pop(context),
            minVerticalPadding: 0,
            selected: true,
            selectedTileColor: MyColors.seed.withOpacity(0.15),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
            leading: const Icon(CupertinoIcons.square_grid_2x2),
            title: const Text('Dashboard'),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(context, CupertinoPageRoute(builder: (_)=> const UserRegReqScreen()));
            },
            leading: const Icon(CupertinoIcons.news),
            title: const Text('Form'),
          ),

          ListTile(
            onTap: () => Navigator.pop(context),
            leading: const Icon(CupertinoIcons.person),
            title: const Text('HR Manager'),
          ),

          const Spacer(),
          const Divider(),

          ListTile(
            iconColor: MyColors.destructiveRed,
            textColor: MyColors.destructiveRed,
            leading: const Icon(CupertinoIcons.power),
            title: const Text('Log Out'),
            onTap: () {
              AuthDb.deleteAuthData();
              MyRoutes.pushAndRemoveUntil(context, const LogInScreen());
            },
          )
          //end list items
        ],
      ),
    );
  }
}
