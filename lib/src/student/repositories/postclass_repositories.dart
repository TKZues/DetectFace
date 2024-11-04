import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/student/model/attendancehistory_model.dart';
import 'package:findy/src/student/model/postclass_model.dart';
import 'package:findy/src/student/service/postclass_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class PostClassRepositories extends BaseRepository<PostClassService> {
  PostClassRepositories(super.service);

  final List<PostClassModel> _postclassList = [];
  List<PostClassModel> get postclassList => _postclassList;

     final List<AttendanceHistoryModel> _attendancehistoryList = [];
  List<AttendanceHistoryModel> get attendancehistoryList => _attendancehistoryList;

  Future<void> getpost(String classID) async {
    startLoading();
    try {
      final res = await service.getpost(classID: classID);
      if (res.statusCode != 200) {
        _postclassList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _postclassList.clear();
        for (final item in res.data['posts']) {
          final notificationItem = PostClassModel.fromJson(item);
          _postclassList.add(notificationItem);
        }
      } else {
        _postclassList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _postclassList.clear();
      _error(error.message.toString());
    } catch (error) {
      _postclassList.clear();
      _error(error.toString());
    }
  }

  Future<void> sendpost(String classID, String decription, String image) async {
    startLoading();
    try {
      final res = await service.sendpost(classID: classID, decription:decription, image: image );
      if (res.statusCode != 200) {
         CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 201) {
        CustomSnackbar.snackbarSuccess(res.data['message']);
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

  Future<void> getinoutinclass(String classID) async {
    startLoading();
    try {
      final res = await service.getinoutinclass(classID: classID);
      if (res.statusCode == 400) {
        _attendancehistoryList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode != 200) {
        _attendancehistoryList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 404) {
        _attendancehistoryList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _attendancehistoryList.clear();
        for (final item in res.data) {
          final attendanceItem = AttendanceHistoryModel.fromJson(item);
          _attendancehistoryList.add(attendanceItem);
        }
      } else {
        _attendancehistoryList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _attendancehistoryList.clear();
      _error(error.message.toString());
    } catch (error) {
      _attendancehistoryList.clear();
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
