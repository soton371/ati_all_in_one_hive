import 'dart:async';
import 'dart:io';

import 'package:ati_all_in_one_hive/models/notification_list_mod.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<CallNotification>(
      (event, emit) async {
        debugPrint("CallNotification");
        final Uri url = Uri.parse("http://192.168.0.164/soton/ati-all-in-one/raw/master/assets/jsons/notifications.json");
        try {
          final response = await http.get(url);
          if (response.statusCode != 200) {
            emit(NotificationFailedState(errorMsg: "server response ${response.statusCode}"));
            return;
          }
          // final notifications = json.decode(response.body);
          final notificationList = notificationListModelFromJson(response.body);
          emit(NotificationFetchedState(notificationList: notificationList));
        } on TimeoutException {
          emit(const NotificationFailedState(errorMsg: "Server timed out"));
        } on SocketException {
          emit(const NotificationFailedState(errorMsg: "Check your internet connection"));
        } catch (e) {
          debugPrint("e: $e");
          emit(const NotificationFailedState(errorMsg: "Something went wrong"));
        }
      },
    );
  }
}
