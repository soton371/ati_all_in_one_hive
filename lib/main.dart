import 'package:ati_all_in_one_hive/blocs/auth/auth_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/fetch_app_list/fetch_app_list_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/notification/notification_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/notification/search_notification/search_notification_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/notification/select_notification/select_notification_bloc.dart';
import 'package:ati_all_in_one_hive/blocs/route/route_bloc.dart';
import 'package:ati_all_in_one_hive/configs/my_colors.dart';
import 'package:ati_all_in_one_hive/db/app_store_db.dart';
import 'package:ati_all_in_one_hive/models/app_store_mod.dart';
import 'package:ati_all_in_one_hive/screens/splash/splash_scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(AppStoreModelAdapter());
  await Hive.openBox<AppStoreModel>(AppStoreDb.appStoreBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<RouteBloc>(
          create: (context) => RouteBloc(),
        ),
        BlocProvider<FetchAppListBloc>(
          create: (context) => FetchAppListBloc(),
        ),
        BlocProvider<NotificationBloc>(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider<SearchNotificationBloc>(
          create: (context) => SearchNotificationBloc(),
        ),
        BlocProvider<SelectNotificationBloc>(
          create: (context) => SelectNotificationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Ati All In One',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.seed),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

