import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartServices1 extends BaseService {
  // ignore: use_super_parameters
  ChartServices1(Dio client) : super(client);

  Future<Response> checkinsumary({required String date}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {"teacherId": userID, "date": date};
    return client.post("$baseUrl/api/classall/subject-counts/today",
        data: params);
  }

  Future<Response> getinoutinclass(
      {required String classID, required String studentID}) async {
    Map<String, dynamic> params = {
      "studentID": studentID,
      "classID": classID,
    };
    return client.post("$baseUrl/api/face/attendance-history", data: params);
  }

  Future<Response> checkinsumarystudent({required String studentID, required String classID, required String date}) async {
    Map<String, dynamic> params = {
      "studentID": studentID,
      "classID": classID,
      "date": date
    };
    return client.post("$baseUrl/api/classall/teacher/check-in-summary", data: params);
  }

  Future<Response> checkinweek() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {"teacherID": userID};
    return client.post("$baseUrl/api/classall/check-weekjubjectwithtime",
        data: params);
  }

  Future<Response> checkweekjubjectwithtime() {
    Map<String, dynamic> params = {};
    return client.post("$baseUrl/api/classall/check-weekjubjectwithtime",
        data: params);
  }

  Future<Response> reportchuyencan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? studentId = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentId": studentId,
    };

    return client.post("$baseUrl/api/classall/getClassInfoByStudentId",
        data: params);
  }

  Future<Response> reportchuyencanstudent(
      {required String studentID,
      required String classID,
      required String date}) async {
    Map<String, dynamic> params = {
      "studentId": studentID,
      "classID": classID,
      "date": date
    };

    return client.post(
        "$baseUrl/api/classall/teacher/getClassInfoByStudentIdTeacher",
        data: params);
  }
}
