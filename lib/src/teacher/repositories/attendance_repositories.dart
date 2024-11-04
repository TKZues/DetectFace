import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/teacher/model/attendance_model.dart';
import 'package:findy/src/teacher/model/class_model.dart';
import 'package:findy/src/teacher/model/classes_model.dart';
import 'package:findy/src/teacher/service/attendance_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class AttendanceRepositories1 extends BaseRepository<AttendanceServices1> {
  // ignore: use_super_parameters
  AttendanceRepositories1(AttendanceServices1 service) : super(service);

  final List<AttendanceModel> _attendanceList = [];
  List<AttendanceModel> get attendanceList => _attendanceList;

  final List<ClassesModel> _noattendanceList = [];
  List<ClassesModel> get noattendanceList => _noattendanceList;
  final List<ClassesModel> _classList = [];
  List<ClassesModel> get classList => _classList;
  final List<ClassModel> _classallList = [];
  List<ClassModel> get classallList => _classallList;
  bool _checkin = false;
  bool get checkin => _checkin;
  bool _checkout = false;
  bool get checkout => _checkout;

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
      if (res.statusCode == 404) {
        _attendanceList.clear();
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

  Future<void> getnoinout(String date) async {
    startLoading();
    try {
      final res = await service.getnoinout(date: date);
      if (res.statusCode == 400) {
        _noattendanceList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode != 200) {
        _noattendanceList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        if (res.data != null) {
          _noattendanceList.clear();
          for (final item in res.data) {
            final attendanceItem = ClassesModel.fromJson(item);
            _noattendanceList.add(attendanceItem);
          }
        } else {
          _noattendanceList.clear();
        }
      } else {
        _noattendanceList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _noattendanceList.clear();
      _error(error.message.toString());
    } catch (error) {
      _noattendanceList.clear();
      _error(error.toString());
    }
  }

  Future<void> getstatusinout(String subjectID) async {
    startLoading();
    try {
      final res = await service.getstatusinout(subjectID: subjectID);
      if (res.statusCode == 400) {
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode != 200) {
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        if (res.data['status'] == "not-checked-in") {
          _checkin = true;
          _checkout = true;
        } else if (res.data['status'] == "checked-in") {
          _checkin = false;
          _checkout = true;
        } else {
          _checkin = false;
          _checkout = false;
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
