import 'dart:convert';

import 'package:ati_all_in_one_hive/configs/my_urls.dart';
import 'package:ati_all_in_one_hive/db/auth_db.dart';
import 'package:ati_all_in_one_hive/models/auth_mod.dart';
import 'package:ati_all_in_one_hive/models/token_mod.dart';
import 'package:ati_all_in_one_hive/services/fetch_token.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TokenModel tokenModel = TokenModel();

  AuthBloc() : super(AuthInitial()) {
    on<DoLoginEvent>((event, emit) async {
      debugPrint("call DoLoginEvent");
      emit(AuthLoadingState());
      if (event.email.isEmpty) {
        emit(const AuthFailedState("Attention", "Please enter valid username"));
        return;
      }
      if (event.password.isEmpty) {
        emit(const AuthFailedState("Attention", "Please enter valid password"));
        return;
      }
      final url = Uri.parse(MyUrls.appLogin);
      final payload = jsonEncode({"appId": "0", "userPaswd": event.password, "usersName": event.email, "versionCode": "0"});

      tokenModel = await fetchToken();

      if (tokenModel.accessToken == null) {
        emit(const AuthFailedState("Login Failed", "Access token is missing"));
        return;
      }

      final header = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${tokenModel.accessToken}'};
      try {
        final response = await http.post(url, headers: header, body: payload);

        if (response.statusCode == 200) {
          final authModel = authModelFromJson(response.body);
          if (authModel.statusCode != null && authModel.statusCode == 200) {
            final userInfo = authModel.objResponse;
            if(userInfo == null){
              emit(const AuthFailedState("Login Failed", "User info missing"));
              return;
            }
            AuthDb.putAuthData(token: tokenModel.accessToken, expireInSec: tokenModel.expiresIn, isRemember: event.isRemember, user: userInfo.usersName);
            emit(AuthSuccessState());
          } else {
            emit(const AuthFailedState("Login Failed", "Please enter valid username/password"));
          }
        } else {
          emit(AuthFailedState("Login Failed", "${response.statusCode} please try again"));
        }
      } catch (e) {
        debugPrint("exception e: $e");
        emit(const AuthFailedState("Login Failed", "Something went wrong"));
      }
    });
  }
}
