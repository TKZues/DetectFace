import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/student/model/diemchuyencan_model.dart';
import 'package:findy/src/student/screen/home/management_statictis/chart/linechart_thoigiancheckintrungbinh/thoigiancheckintrungbinh.dart';
import 'package:findy/src/student/screen/home/management_statictis/chart/solandiemdanhtheotuan/bar%20chart/bar_charts.dart';
import 'package:findy/src/student/service/chart_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class ChartRepositories extends BaseRepository<ChartServices> {
  ChartRepositories(super.service);
  int _totalSubjects = 0;
  int get totalSubjects => _totalSubjects;

  int _checkedInCount = 0;
  int get checkedInCount => _checkedInCount;

  final List<ChartColumnDataweek> _listChartColumnDataweek = [];
  List<ChartColumnDataweek> get listChartColumnDataweek =>
      _listChartColumnDataweek;

  final List<ThoigiancheckintrungbinhData> _listcheckweekjubjectwithtime = [];
  List<ThoigiancheckintrungbinhData> get listcheckweekjubjectwithtime =>
      _listcheckweekjubjectwithtime;

  final List<DiemchuyencanModel> _listDiemchuyencan = [];
  List<DiemchuyencanModel> get listDiemchuyencan => _listDiemchuyencan;

  Future<void> checkinsumary() async {
    startLoading();
    try {
      final res = await service.checkinsumary();
      if (res.statusCode != 200) {
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _totalSubjects = res.data['totalSubjects'];
        _checkedInCount = res.data['checkedOutCount'];
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

  Future<void> reportchuyencan(String date) async {
    startLoading();
    try {
      final res = await service.reportchuyencan(date: date);
      if (res.statusCode != 200) {
        _listDiemchuyencan.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _listDiemchuyencan.clear();
        for(final item in res.data){
          final itemchuyencan = DiemchuyencanModel.fromJson(item);
          _listDiemchuyencan.add(itemchuyencan);
        }
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
