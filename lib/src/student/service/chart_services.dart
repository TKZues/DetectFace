import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartServices extends BaseService {
  // ignore: use_super_parameters
  ChartServices(Dio client) : super(client);

  Future<Response> checkinsumary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? studentID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentID": studentID
    };
    return client.post("$baseUrl/api/classall/check-in-summary", data: params);
  }

  Future<Response> checkinweek() async {
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? studentID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentID": studentID
    };
    return client.post("$baseUrl/api/classall/check-in-week", data: params);
  }

  Future<Response> checkweekjubjectwithtime()  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? studentID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentID": studentID
    };
    return client.post("$baseUrl/api/classall/check-weekjubjectwithtime", data: params);
  }

  Future<Response> reportchuyencan({required String date}) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     String? studentId = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentId" :studentId,
      "date": date
    };

    return client.post("$baseUrl/api/classall/getClassInfoByStudentId", data: params);
  }
}
