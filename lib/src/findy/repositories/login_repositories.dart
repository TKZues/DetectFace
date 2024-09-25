import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/src/findy/service/login_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepositories extends BaseRepository<LoginServices> {
  LoginRepositories(super.service);

  // final List<NotificationModel> _NotificationList = [];
  // List<NotificationModel> get NotificationList => _NotificationList;

  // int _notificationCount = 0;
  // int get notificationcount => _notificationCount;

  Future<void> signup(String username, String password, String email) async {
    startLoading();
    try {
      final res = await service.signup(
          email: email, password: password, username: username);
      if (res.statusCode != 200) {
        finishLoading();
        CustomSnackbar.snackbarError("Thông tin bị sai");
        return;
      }
      if (res.statusCode == 200) {
        if (res.data["status"] == "OK") {
          CustomSnackbar.snackbarSuccess("Thành công");
        }
      } else {
        CustomSnackbar.snackbarError(res.data['msg']);
      }
      finishLoading();
    } on DioError catch (error) {
      _error(error.message.toString());
    } catch (error) {
      _error(error.toString());
    }
  }

  Future<void> login(
      String password, String email, BuildContext context) async {
    startLoading();
    try {
      final res = await service.login(email: email, password: password);
      if (res.statusCode != 200) {
        finishLoading();
        CustomSnackbar.snackbarError("Thông tin bị sai");
        return;
      }
      if (res.statusCode == 200) {
        if (res.data["status"] == "OK") {
          CustomSnackbar.snackbarSuccess("Đăng nhập thành công thành công");
          late SharedPreferences sharedPreferences;
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString(
              SharePreferenceKeys.userID, res.data['user']['id']);
          String route = "/bottom";
          Timer(const Duration(milliseconds: 500), () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(route, (route) => false);
          });
        }
      } else {
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _error(error.message.toString());
    } catch (error) {
      _error(error.toString());
    }
  }

  _error(String message) {
    finishLoading();
    errorMessage = message.toString();
    if (message.isNotEmpty) {
      CustomSnackbar.snackbarError(message);
    }
  }
}
