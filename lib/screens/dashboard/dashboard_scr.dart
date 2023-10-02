import 'package:ati_all_in_one_hive/blocs/fetch_app_list/fetch_app_list_bloc.dart';
import 'package:ati_all_in_one_hive/screens/dashboard/components/dashboard_elements.dart';
import 'package:ati_all_in_one_hive/screens/notification/notification_scr.dart';
import 'package:ati_all_in_one_hive/widgets/my_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchAppListBloc>().add(DoFetchAppListEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (_) => const NotificationScreen()));
              },
              icon: const Icon(CupertinoIcons.bell)),
        ],
      ),
      drawer: const MyDrawer(),
      body: const DashboardElements(),
    );
  }
}
