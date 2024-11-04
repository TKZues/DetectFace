import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectFaceLiveService1 extends BaseService {
  // ignore: use_super_parameters
  DetectFaceLiveService1(Dio client) : super(client);

  Future<Response> postface(
      {required String filePath1,
      required String filePath2,
      required String filePath3,
      required String label}) async {
    FormData formData = FormData.fromMap({
      "File1": await MultipartFile.fromFile(filePath1, filename: "image1.jpg"),
      "File2": await MultipartFile.fromFile(filePath2, filename: "image2.jpg"),
      "File3": await MultipartFile.fromFile(filePath3, filename: "image3.jpg"),
      "label": label,
    });
    return client.post("$baseUrl/api/face/post-face", data: formData);
  }

  Future<Response> checkface(
      {required String filePath1, required String classID, required String beginTime,required String endTime}) async {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    FormData formData = FormData.fromMap({
      "File1": await MultipartFile.fromFile(filePath1, filename: "image1.jpg"),
      "studentID": userID,
      "subjectID": classID,
      "beginTime": beginTime,
      "endTime": endTime
    });
    return client.post("$baseUrl/api/face/check-face", data: formData);
  }
}
