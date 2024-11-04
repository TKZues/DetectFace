import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/student/model/inforstudent_model.dart';
import 'package:findy/src/student/model/notification_model.dart';
import 'package:findy/src/student/service/notification_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class NotificationRepositories extends BaseRepository<NotificationService> {
  NotificationRepositories(super.service);

  final List<NotificationModel> _notificationList = [];
  List<NotificationModel> get notificationList => _notificationList;

  final List<NotificationSocketModel> _notificationSocketList = [];
  List<NotificationSocketModel> get notificationSocketList => _notificationSocketList;

    final List<InforStudentModel> _inforStudentList = [];
  List<InforStudentModel> get inforStudentList => _inforStudentList;


  int _notificationCount = 0;
  int get notificationcount => _notificationCount;

  Future<void> getNotification() async {
    startLoading();
    try {
      final res = await service.getNotification();
      if (res.statusCode != 200) {
        _notificationList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _notificationList.clear();
        for (final item in res.data) {
          final notificationItem = NotificationModel.fromJson(item);
          _notificationList.add(notificationItem);
        }
      } else {
        _notificationList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _notificationList.clear();
      _error(error.message.toString());
    } catch (error) {
      _notificationList.clear();
      _error(error.toString());
    }
  }

  Future<void> getNotificationSocket() async {
    startLoading();
    try {
      final res = await service.getNotificationSocket();
      if (res.statusCode != 200) {
        _notificationSocketList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _notificationSocketList.clear();
        for (final item in res.data) {
          final notificationItem = NotificationSocketModel.fromJson(item);
          _notificationSocketList.add(notificationItem);
        }
      } else {
        _notificationSocketList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _notificationSocketList.clear();
      _error(error.message.toString());
    } catch (error) {
      _notificationSocketList.clear();
      _error(error.toString());
    }
  }

  Future<void> getNotificationCount() async {
    _notificationCount = 0;
    startLoading();
    try {
      final res = await service.getNotificationCount();
      if (res.statusCode == 200) {
        _notificationCount = res.data['count'];
      } else {
        return;
      }
      finishLoading();
    } on DioError {
      return;
    } catch (error) {
      return;
    }
    notifyListeners();
  }

  Future<void> getStudentInfor() async {
  startLoading();
  try {
    final res = await service.getStudentInfor();
    if (res.statusCode != 200) {
      _inforStudentList.clear();
      finishLoading();
      return;
    }
    
    // Assuming the API returns a single student object instead of a list
    if (res.statusCode == 200) {
      _inforStudentList.clear();
      final notificationItem = InforStudentModel.fromJson(res.data);
      _inforStudentList.add(notificationItem);
    } else {
      _inforStudentList.clear();
      CustomSnackbar.snackbarError(res.data['message']);
    }
    finishLoading();
  } on DioError catch (error) {
    _inforStudentList.clear();
    _error(error.message.toString());
  } catch (error) {
    _inforStudentList.clear();
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
