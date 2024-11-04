import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostClassService extends BaseService {
  // ignore: use_super_parameters
  PostClassService(Dio client) : super(client);

  Future<Response> getpost({required String classID}) async {
    return client.get(
      "$baseUrl/api/posts/posts/class/$classID",
    );
  }

   Future<Response> getinoutinclass({required String classID}) async {
             SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "studentID": userID,
      "classID": classID,
    };
    return client.post("$baseUrl/api/face/attendance-history",data: params);
  }


  Future<Response> sendpost(
      {required String classID,
      required String decription,
      required String image}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    Map<String, dynamic> params = {
      "userID": userID,
      "classID": classID,
      "description": decription,
      "imageUrl": image
          
    };

    return client.post(
      "$baseUrl/api/posts/posts",
      data: params,
    );
  }
}
