import 'package:ati_all_in_one_hive/configs/my_urls.dart';
import 'package:ati_all_in_one_hive/db/app_store_db.dart';
import 'package:ati_all_in_one_hive/models/app_store_mod.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
part 'fetch_app_list_event.dart';
part 'fetch_app_list_state.dart';

class FetchAppListBloc extends Bloc<FetchAppListEvent, FetchAppListState> {
  List<AppStoreModel> appList = [];
  List<AppStoreModel> localAppList = [];
  List<AppStoreModel> installedAppList = [];
  List<AppStoreModel> notInstalledAppList = [];

  FetchAppListBloc() : super(FetchAppListInitial()) {
    on<DoFetchAppListEvent>((event, emit) async {
      debugPrint('call on<DoFetchAppListEvent>');
      emit(FetchAppListLoadingState());
      localAppList = AppStoreDb.getAllAppStoreModels();
      if (localAppList.isNotEmpty) {
        for (var element in localAppList) {
          final isInstalled = await LaunchApp.isAppInstalled(androidPackageName: element.appId);
          element.appInstalled = "$isInstalled";
          AppStoreDb.updateAppStoreModel(element);
        }

        installedAppList = localAppList.where((element) => element.appInstalled == "true").toList();
        notInstalledAppList = localAppList.where((element) => element.appInstalled == "false").toList();

        installedAppList.sort((a, b) {
          final aa = a.appOrder;
          final bb = b.appOrder;
          if (aa != null && bb != null) {
            return aa.compareTo(bb);
          } else {
            return 0;
          }
        });

        emit(FetchAppListFetchedState(localAppList, installedAppList, notInstalledAppList));
      }

      try {
        Uri url = Uri.parse(MyUrls.appList);
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final apps = appStoreModelFromJson(response.body);
          if (apps.length == localAppList.length) {
            debugPrint("apps.length == localAppList.length");
            return;
          }

          for (var element in apps) {
            bool isInstalled = await LaunchApp.isAppInstalled(androidPackageName: element.appId);
            element.appInstalled = "$isInstalled";
            AppStoreDb.createAppStoreModel(element);
            // boxAppStore.add(element); //for local save apps
            // element.save();
          }

          installedAppList = apps.where((element) => element.appInstalled == "true").toList();
          notInstalledAppList = apps.where((element) => element.appInstalled == "false").toList();
          appList = apps;

          installedAppList.sort((a, b) {
            final aa = a.appOrder;
            final bb = b.appOrder;
            if (aa != null && bb != null) {
              return aa.compareTo(bb);
            } else {
              return 0;
            }
          });

          emit(FetchAppListFetchedState(appList, installedAppList, notInstalledAppList));
          //end status 200
        } else {
          //start 404, 500
          debugPrint('bloc DoFetchAppListEvent response.statusCode: ${response.statusCode}');
          emit(FetchAppListFailedState());
        }
      } catch (e) {
        debugPrint('bloc DoFetchAppListEvent e: $e');
        emit(FetchAppListFailedState());
      }
    });

    //for refresh data
    on<RefreshAppListEvent>((event, emit) async {
      debugPrint('call RefreshAppListEvent');
      localAppList = AppStoreDb.getAllAppStoreModels();
      if (localAppList.isNotEmpty) {
        for (var element in localAppList) {
          final isInstalled = await LaunchApp.isAppInstalled(androidPackageName: element.appId);
          element.appInstalled = "$isInstalled";
          AppStoreDb.updateAppStoreModel(element);
        }

        installedAppList = localAppList.where((element) => element.appInstalled == "true").toList();
        notInstalledAppList = localAppList.where((element) => element.appInstalled == "false").toList();

        installedAppList.sort((a, b) {
          final aa = a.appOrder;
          final bb = b.appOrder;
          if (aa != null && bb != null) {
            return aa.compareTo(bb);
          } else {
            return 0;
          }
        });

        emit(FetchAppListFetchedState(localAppList, installedAppList, notInstalledAppList));
      }
    });
  }
}
