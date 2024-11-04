import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelineServices1 extends BaseService {
  // ignore: use_super_parameters
  TimelineServices1(Dio client) : super(client);

  Future<Response> getSchedule() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    return client.get(
      "$baseUrl/api/schedules/user/$userID",
    );
  }

  Future<Response> createSchedule(
      {required String curriculumName,
      required String ngay,
      required String beginTime,
      required String endTime,
      required String startDate,
      required String endDate,
      required String address}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "userID": userID, // Replace with an actual ObjectId
      "curriculumName": curriculumName,
      "ngay": ngay,
      "beginTime": beginTime,
      "endTime": endTime,
      "startDate": startDate,
      "endDate": endDate,
      "address": address,
    };

    return client.post(
      "$baseUrl/api/schedules",data: params 
    );
  }
}
