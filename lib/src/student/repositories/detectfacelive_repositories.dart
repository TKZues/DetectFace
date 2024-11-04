import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/student/screen/home/management_subject/classes_manage_screen.dart';
import 'package:findy/src/student/service/detectfacelive_service.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';

class DetectFaceLiveRepositories extends BaseRepository<DetectFaceLiveService> {
  DetectFaceLiveRepositories(super.service);

  Future<void> postface(
      {required String filePath1,
      required String filePath2,
      required String filePath3,
      required String label}) async {
    startLoading();
    try {
      final res = await service.postface(
          filePath1: filePath1,
          filePath2: filePath2,
          filePath3: filePath3,
          label: label);
      if (res.statusCode != 200) {
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
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

  Future<void> checkface(
      {required String filePath1,
      required String classID,
      required String beginTime,
      required String endTime,
      required BuildContext context}) async {
    startLoading();
    try {
      final res = await service.checkface(
          filePath1: filePath1,
          classID: classID,
          beginTime: beginTime,
          endTime: endTime);
      if (res.statusCode == 200) {
        if (res.data['results'] != null && res.data['results'].isNotEmpty) {
          CustomSnackbar.snackbarSuccess(res.data['results'][0]['_label'] +
              " đã checkin/ checkout thành công");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ClassesManageScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          CustomSnackbar.snackbarError("Lỗi");
        }
      } else {
        CustomSnackbar.snackbarError(res.data['message']);
        return;
      }
      finishLoading();
    } on DioError {
      CustomSnackbar.snackbarError("Lỗi");
      finishLoading();
      return;
    } catch (error) {
      CustomSnackbar.snackbarError(error.toString());
      finishLoading();
      return;
    }
    notifyListeners();
  }

  _error(String message) {
    finishLoading();
    errorMessage = message.toString();
    if (message.isNotEmpty) {
      CustomSnackbar.snackbarError(message);
    }
  }
}
