import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/teacher/model/attendancehistory_model.dart';
import 'package:findy/src/teacher/model/diemchuyencan_model.dart';
import 'package:findy/src/teacher/screen/home/management_statictis/chart/linechart_thoigiancheckintrungbinh/thoigiancheckintrungbinh.dart';
import 'package:findy/src/teacher/screen/home/management_statictis/chart/solandiemdanhtheotuan/bar%20chart/bar_charts.dart';
import 'package:findy/src/teacher/service/chart_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class ChartRepositories1 extends BaseRepository<ChartServices1> {
  ChartRepositories1(super.service);
  int _totalSubjects = 0;
  int get totalSubjects => _totalSubjects;

  int _checkedInCount = 0;
  int get checkedInCount => _checkedInCount;

    final List<AttendanceHistoryModel> _attendancehistoryList = [];
  List<AttendanceHistoryModel> get attendancehistoryList => _attendancehistoryList;
  final List<ChartColumnDataweek> _listChartColumnDataweek = [];
  List<ChartColumnDataweek> get listChartColumnDataweek =>
      _listChartColumnDataweek;

  final List<ThoigiancheckintrungbinhData> _listcheckweekjubjectwithtime = [];
  List<ThoigiancheckintrungbinhData> get listcheckweekjubjectwithtime =>
      _listcheckweekjubjectwithtime;

  final List<DiemchuyencanModel> _listDiemchuyencan = [];
  List<DiemchuyencanModel> get listDiemchuyencan => _listDiemchuyencan;

  Future<void> checkinsumary(String date) async {
    startLoading();
    try {
      final res = await service.checkinsumary(date: date);
      if (res.statusCode != 200) {
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _totalSubjects = res.data['totalSubjects'];
        _checkedInCount = res.data['checkedOutCount'];
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

  Future<void> getinoutinclass(String classID, String studentID) async {
    startLoading();
    try {
      final res = await service.getinoutinclass(classID: classID, studentID: studentID);
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


  Future<void> checkinsumarystudent(String studentID, String classID, String date) async {
    startLoading();
    try {
      final res = await service.checkinsumarystudent(studentID: studentID, classID: classID, date: date);
      if (res.statusCode != 200) {
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _totalSubjects = res.data['totalSubjects'];
        _checkedInCount = res.data['checkedOutCount'];
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

  Future<void> checkinweek() async {
    startLoading();
    try {
      final res = await service.checkinweek();
      if (res.statusCode != 200) {
        _listChartColumnDataweek.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _listChartColumnDataweek.clear();
        for (final item in res.data['weekData']) {
          final itemData = ChartColumnDataweek.fromJson(item);
          _listChartColumnDataweek.add(itemData);
        }
      } else {
        _listChartColumnDataweek.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _listChartColumnDataweek.clear();
      _error(error.message.toString());
    } catch (error) {
      _listChartColumnDataweek.clear();
      _error(error.toString());
    }
  }

  Future<void> checkweekjubjectwithtime() async {
    startLoading();
    try {
      final res = await service.checkweekjubjectwithtime();
      if (res.statusCode != 200) {
        _listcheckweekjubjectwithtime.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _listcheckweekjubjectwithtime.clear();
        for (final item in res.data['weekData']) {
          final itemData = ThoigiancheckintrungbinhData.fromJson(item);
          _listcheckweekjubjectwithtime.add(itemData);
        }
      } else {
        _listcheckweekjubjectwithtime.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _listcheckweekjubjectwithtime.clear();
      _error(error.message.toString());
    } catch (error) {
      _listcheckweekjubjectwithtime.clear();
      _error(error.toString());
    }
  }

  // Future<void> reportchuyencan() async {
  //   startLoading();
  //   try {
  //     final res = await service.reportchuyencan();
  //     if (res.statusCode != 200) {
  //       _listDiemchuyencan.clear();
  //       finishLoading();
  //       return;
  //     }
  //     if (res.statusCode == 200) {
  //       _listDiemchuyencan.clear();
  //       for(final item in res.data){
  //         final itemchuyencan = DiemchuyencanModel.fromJson(item);
  //         _listDiemchuyencan.add(itemchuyencan);
  //       }
  //     } else {
  //       _listDiemchuyencan.clear();
  //       CustomSnackbar.snackbarError(res.data['message']);
  //     }
  //     finishLoading();
  //   } on DioError catch (error) {
  //     _listDiemchuyencan.clear();
  //     _error(error.message.toString());
  //   } catch (error) {
  //     _listDiemchuyencan.clear();
  //     _error(error.toString());
  //   }
  // }

  Future<void> reportchuyencanstudent(String studentID, String classID, String date) async {
    startLoading();
    try {
      final res = await service.reportchuyencanstudent(
          studentID: studentID, classID: classID,date: date);
      if (res.statusCode != 200) {
        _listDiemchuyencan.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _listDiemchuyencan.clear();
        final itemchuyencan = DiemchuyencanModel.fromJson(res.data);
        _listDiemchuyencan.add(itemchuyencan);
      } else {
        _listDiemchuyencan.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _listDiemchuyencan.clear();
      _error(error.message.toString());
    } catch (error) {
      _listDiemchuyencan.clear();
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
