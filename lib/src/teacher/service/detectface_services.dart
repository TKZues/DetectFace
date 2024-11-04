// import 'package:dio/dio.dart';
// import 'package:findy/constant/share_preference_key.dart';
// import 'package:findy/utils/api/api_util.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiDio {
//   Future<Dio> createDioApp() async {
//     return Dio(BaseOptions(
//         connectTimeout: 15000,
//         receiveTimeout: 15000,
//         baseUrl: "https://5d3e-2405-4803-c843-31d0-fce4-863-fb4f-e63b.ngrok-free.app",
//         followRedirects: false,
//         validateStatus: (status) {
//           return status! < 599;
//         }));
//   }

//   // login
//   Future<dynamic> postface(
//       {required String filePath1,
//       required String filePath2,
//       required String filePath3,
//       required String label}) async {
//     var dio = await createDioApp();
//     FormData formData = FormData.fromMap({
//       "File1": await MultipartFile.fromFile(filePath1, filename: "image1.jpg"),
//       "File2": await MultipartFile.fromFile(filePath2, filename: "image2.jpg"),
//       "File3": await MultipartFile.fromFile(filePath3, filename: "image3.jpg"),
//       "label": label,
//     });
//     var res = await HandleApi.execute(
//         dio.post("/api/face/post-face", data: formData), "postface response: ");

//     return res;
//   }

//   Future<dynamic> checkface(
//       {required String inputImage,
//       required String classID}) async {
//          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
//     var dio = await createDioApp();
//     FormData formData = FormData.fromMap({
//       "studentID": userID,
//       "subjectID": classID,
//       "inputImage": inputImage,
//     });
//     var res = await HandleApi.execute(
//         dio.post("/api/face/check-face", data: formData), "checkface repose: ");

//     return res;
//   }

// Future<dynamic> getinout({required String label}) async{
//   var dio = await createDioApp();

//   var res = await HandleApi.execute(dio.post("/api/face/check-in-check-out/$label"), "getinout repose: ");

//   return res;
// }
// }

import 'package:dio/dio.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/utils/api/api_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiDio {
  Future<Dio> createDioApp() async {
    return Dio(BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        baseUrl:
            "https://0872-123-25-190-41.ngrok-free.app",
        followRedirects: false,
        validateStatus: (status) {
          return status! < 599;
        }));
  }

  // login
  Future<dynamic> postface(
      {required String filePath1,
      required String filePath2,
      required String filePath3,
      required String label}) async {
    var dio = await createDioApp();
    FormData formData = FormData.fromMap({
      "File1": await MultipartFile.fromFile(filePath1, filename: "image1.jpg"),
      "File2": await MultipartFile.fromFile(filePath2, filename: "image2.jpg"),
      "File3": await MultipartFile.fromFile(filePath3, filename: "image3.jpg"),
      "label": label,
    });
    var res = await HandleApi.execute(
        dio.post("/api/face/post-face", data: formData), "postface response: ");

    return res;
  }

  Future<dynamic> checkface(
      {required String filePath1, required String classID, required String beginTime,required String endTime}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userID = sharedPreferences.getString(SharePreferenceKeys.userID);
    var dio = await createDioApp();
    FormData formData = FormData.fromMap({
      "File1": await MultipartFile.fromFile(filePath1, filename: "image1.jpg"),
      "studentID": userID,
      "subjectID": classID,
      "beginTime": beginTime,
      "endTime": endTime
    });
    var res = await HandleApi.execute(
        dio.post("/api/face/check-face", data: formData), "checkface repose: ");

    return res;
  }

  // Future<dynamic> getinout({required String label}) async{
  //   var dio = await createDioApp();

  //   var res = await HandleApi.execute(dio.post("/api/face/check-in-check-out/$label"), "getinout repose: ");

  //   return res;
  // }
}
