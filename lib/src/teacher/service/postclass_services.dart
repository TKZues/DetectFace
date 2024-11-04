import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostClassService1 extends BaseService {
  // ignore: use_super_parameters
  PostClassService1(Dio client) : super(client);

  Future<Response> getpost({required String classID}) async {
    return client.get(
      "$baseUrl/api/posts/posts/class/$classID",
    );
  }

  Future<Response> getclassteacher() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);

    return client.get("$baseUrl/api/classall/classteacher/$userID");
  }
}
