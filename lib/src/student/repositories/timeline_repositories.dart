import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:findy/src/student/model/timeline_model.dart';
import 'package:findy/src/student/service/timeline_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimelineRepositories extends BaseRepository<TimelineServices> {
  TimelineRepositories(super.service);

  // Khởi tạo danh sách màu sắc
  final List<Color> _colorCollection = <Color>[];
  final List<TimelineModel> _scheduleList = [];
  List<TimelineModel> get scheduleList => _scheduleList;

  // Khởi tạo danh sách cuộc hẹn
  final List<Appointment> _appointmentData = [];
  List<Appointment> get appointmentData => _appointmentData;

  // Hàm gọi API lấy lịch hẹn
  Future<void> getSchedule() async {
    startLoading();

    try {
      // Khởi tạo màu sắc trước khi thêm lịch hẹn
      _initializeEventColor();

      // Gọi API lấy dữ liệu
      final res = await service.getSchedule();

      // Xử lý khi mã trạng thái khác 200
      if (res.statusCode != 200) {
        _scheduleList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _scheduleList.clear();
        _appointmentData.clear();
        final Random random = Random();
        // Lặp qua dữ liệu từ API
        for (final data in res.data['data']) {
          final timelineItem = TimelineModel.fromJson(data);
          _scheduleList.add(timelineItem);
          if (timelineItem.curriculumName != null) {
            int numberOfPeriods = timelineItem.numberOfPeriods ?? 0;
            DateFormat dateFormat = DateFormat("dd/MM/yyyy");
            DateFormat starttimeFormat = DateFormat("hh:mm");
            DateFormat endtimeFormat = DateFormat("hh:mm");

            // Parse the string into a DateTime object
            DateTime parsedDate =
                dateFormat.parse(timelineItem.startDate ?? "");

            DateTime parsedStartTime =
                starttimeFormat.parse(timelineItem.beginTime ?? "");
            DateTime parsedEndTime =
                endtimeFormat.parse(timelineItem.endTime ?? "");
            Appointment meetingData = Appointment(
              subject: timelineItem.curriculumName ?? "",
              startTime: DateTime(
                  parsedDate.year,
                  parsedDate.month,
                  parsedDate.day,
                  parsedStartTime.hour,
                  parsedStartTime.minute,
                  0),
              endTime: DateTime(
                      parsedDate.year,
                      parsedDate.month,
                      parsedDate.day,
                      parsedEndTime.hour,
                      parsedEndTime.minute,
                      0)
                  .add(Duration(minutes: numberOfPeriods * 45)),
              color: _colorCollection[random.nextInt(
                  _colorCollection.length)], // Lấy màu ngẫu nhiên từ danh sách
              isAllDay: false,
            );
            _appointmentData.add(meetingData); // Thêm cuộc hẹn vào danh sách
          }
        }
      } else {
        _scheduleList.clear();
        CustomSnackbar.snackbarError(
            res.data['message']); // Hiển thị lỗi nếu có
      }

      finishLoading();
    } on DioError catch (error) {
      _scheduleList.clear();
      _error(error.message.toString()); // Xử lý lỗi từ Dio
    } catch (error) {
      _scheduleList.clear();
      _error(error.toString()); // Xử lý lỗi chung
    }
  }

  Future<void> handleSocketDataCamStatus(BuildContext context,Map<String, dynamic> data) async {
    print(data);
    CustomSnackbar.snackbarmotion(
        data['message'],
        () {
          
        },
      );
    notifyListeners();
  }

  Future<void> createSchedule(
      String curriculumName,
      String ngay,
      String beginTime,
      String endTime,
      String startDate,
      String endDate,
      String address) async {
    startLoading();
    try {
      final res = await service.createSchedule(
          curriculumName: curriculumName,
          ngay: ngay,
          beginTime: beginTime,
          endTime: endTime,
          startDate: startDate,
          endDate: endDate,
          address: address);
      if (res.statusCode != 200) {
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        if(res.data['message'] == "Schedule created successfully"){
          CustomSnackbar.snackbarSuccess("Schedule created successfully");
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

  // Hàm xử lý lỗi và hiển thị thông báo
  _error(String message) {
    finishLoading();
    errorMessage = message.toString();
    if (message.isNotEmpty) {
      CustomSnackbar.snackbarError(message); // Hiển thị lỗi qua snackbar
    }
  }

  // Khởi tạo danh sách màu sắc
  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}
