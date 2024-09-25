import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/findy/model/attendance_model.dart';
import 'package:findy/src/findy/model/class_model.dart';
import 'package:findy/src/findy/model/classes_model.dart';
import 'package:findy/src/findy/service/attendance_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class AttendanceRepositories extends BaseRepository<AttendanceServices> {
  // ignore: use_super_parameters
  AttendanceRepositories(AttendanceServices service) : super(service);

  final List<AttendanceModel> _attendanceList = [];
  List<AttendanceModel> get attendanceList => _attendanceList;
  final List<ClassesModel> _classList = [];
  List<ClassesModel> get classList => _classList;

  final List<ClassModel> _classallList = [];
  List<ClassModel> get classallList => _classallList;

  Future<void> getallclassesbyid() async {
    startLoading();
    try {
      final res = await service.getallclassesbyid();
      if (res.statusCode != 200) {
        _classallList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _classallList.clear();
        for (final item in res.data) {
          final classItem = ClassModel.fromJson(item);
          _classallList.add(classItem);
        }
      } else {
        _classallList.clear();
        CustomSnackbar.snackbarError(res.data['msg']);
      }
      finishLoading();
    } on DioError catch (error) {
      _classallList.clear();
      _error(error.message.toString());
    } catch (error) {
      _classallList.clear();
      _error(error.toString());
    }
  }

  Future<void> getclassesbyid(String date) async {
    startLoading();
    try {
      final res = await service.getclassesbyid(date: date);
      if (res.statusCode != 200) {
        _classList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _classList.clear();
        for (final item in res.data) {
          final classItem = ClassesModel.fromJson(item);
          _classList.add(classItem);
        }
      } else {
        _classList.clear();
        CustomSnackbar.snackbarError(res.data['msg']);
      }
      finishLoading();
    } on DioError catch (error) {
      _classList.clear();
      _error(error.message.toString());
    } catch (error) {
      _classList.clear();
      _error(error.toString());
    }
  }

  Future<void> getinout(String date) async {
    startLoading();
    try {
      final res = await service.getinout(date: date);
      if (res.statusCode == 400) {
        _attendanceList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode != 200) {
        _attendanceList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _attendanceList.clear();
        for (final item in res.data) {
          final attendanceItem = AttendanceModel.fromJson(item);
          _attendanceList.add(attendanceItem);
        }
      } else {
        _attendanceList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _attendanceList.clear();
      _error(error.message.toString());
    } catch (error) {
      _attendanceList.clear();
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
