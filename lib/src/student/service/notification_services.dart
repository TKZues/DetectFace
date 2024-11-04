
import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService extends BaseService {
  // ignore: use_super_parameters
  NotificationService(Dio client) : super(client);


  Future<Response> getNotification() async {
    return client.get("$baseUrl/api/notifications",);
  }

  Future<Response> getNotificationCount() async {
    return client.get("$baseUrl/api/notifications/count",);
  }

  Future<Response> getNotificationSocket() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    return client.get("$baseUrl/api/schedules/notifications/$userID",);
  }

   Future<Response> getStudentInfor() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    return client.get("$baseUrl/api/student-info/$userID",);
  }
}

