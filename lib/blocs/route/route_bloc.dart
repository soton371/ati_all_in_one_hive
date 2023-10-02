import 'package:ati_all_in_one_hive/db/auth_db.dart';
import 'package:ati_all_in_one_hive/services/app_data_ser.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {

  RouteBloc() : super(RouteInitial()) {
    on<DoRouteEvent>((event, emit) async {
      debugPrint("call DoRouteEvent");
      final bool? isRemember = await AuthDb.fetchRemember();
      if(isRemember == null || isRemember == false){
        debugPrint("isRemember: $isRemember");
        emit(RouteLoginState());
        return;
      }

      final String? token = await AuthDb.fetchAccessToken();
      if (token == null) {
        debugPrint("token: $token");
        emit(RouteLoginState());
        return;
      }

      final appData = await callAppData();
      if (appData == null) {
        debugPrint("appData: $appData");
        emit(RouteLoginState()); //here alert dialog state
        return;
      }

      final int? appServerVersion = appData.appServerVersion;
      final int? userActiveFlag = appData.userActiveFlag;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersionCode = packageInfo.buildNumber;
      final int localAppVersion = int.parse(appVersionCode);

      if (appServerVersion == null || userActiveFlag == null) {
        emit(RouteLoginState());
        return;
      }

      if (userActiveFlag != 0 && localAppVersion == appServerVersion) {
        emit(RouteDashboardState());
        return;
      }
      if (userActiveFlag == 0) {
        emit(const NoticeAlertState('Account Locked!!', 'Your Account is Locked. Please Contact With Your Service Provider', false));
        return;
      }
      if (localAppVersion < appServerVersion) {
        emit(const NoticeAlertState('New version available!', 'Highly recommended to update App for better experience', true));
        return;
      }
      if (localAppVersion > appServerVersion) {
        emit(const NoticeAlertState('Maintenance Break!!', 'We working on server for new version. please wait', false));
        return;
      }
    });
  }
}
