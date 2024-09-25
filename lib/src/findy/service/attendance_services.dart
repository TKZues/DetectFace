import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceServices extends BaseService {
  AttendanceServices(Dio client) : super(client);
  

  Future<Response> getinout({required String date}) async {
             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentID": userID,
      "date": date,
    };
    return client.post("$baseUrl/api/face/check-in-check-out",data: params);
  }

  Future<Response> getclassesbyid({required String date}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentId": userID,
      "date": date,
    };
    return client.post("$baseUrl/api/classall/find-subjects", data: params);
  }

  Future<Response> getallclassesbyid() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentId": userID
    };
    return client.post("$baseUrl/api/classall/find-class", data: params);
  }
}

