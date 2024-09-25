import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimelineServices extends BaseService {
  TimelineServices(Dio client) : super(client);

  Future<Response> getSchedule() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    return client.get(
      "$baseUrl/api/schedules/user/$userID",
    );
  }
}
