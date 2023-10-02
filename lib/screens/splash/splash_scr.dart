import 'package:ati_all_in_one_hive/blocs/fetch_app_list/fetch_app_list_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/route/route_bloc.dart';
import 'package:ati_all_in_one_hive/configs/my_route.dart';
import 'package:ati_all_in_one_hive/configs/my_sizes.dart';
import 'package:ati_all_in_one_hive/configs/my_urls.dart';
import 'package:ati_all_in_one_hive/screens/auth/login_scr.dart';
import 'package:ati_all_in_one_hive/screens/dashboard/dashboard_scr.dart';
import 'package:ati_all_in_one_hive/utilities/launch_url.dart';
import 'package:ati_all_in_one_hive/widgets/my_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RouteBloc>().add(DoRouteEvent());
    return Scaffold(
      body: BlocListener<RouteBloc, RouteState>(
        listener: (context, state) {
          if (state is RouteLoginState) {
            MyRoutes.pushReplacement(context, const LogInScreen());
          } else if (state is RouteDashboardState) {

            MyRoutes.pushReplacement(context, const DashboardScreen());
          } else if (state is NoticeAlertState) {
            MyRoutes.pushReplacement(context, const LogInScreen());
            state.updateIs
                ? myAlertDialog(context, state.title, state.content,
                    actions: [
                      CupertinoDialogAction(child: const Text('Go to Store'), onPressed: () => launchAppStore(MyUrls.appStoreLink))])
                : myAlertDialog(context, state.title, state.content);
          }
        },
        child: Center(
          child: Image.asset(
            'assets/images/splash.png',
            height: MySizes.height(context) / 5,
          ),
        ),
      ),
    );
  }
}
