// import 'dart:async';
// import 'package:findy/src/findy/service/detectface_services.dart';
// import 'package:findy/utils/model/api_response/base_api_response_model.dart';

// class SignUpRepositories {
//   ApiDio api = ApiDio();

//   //login
//   Future<dynamic> postface(
//       {required String filePath1,
//       required String filePath2,
//       required String filePath3,
//       required String label}) async {
//     var res = await api.postface(
//         filePath1: filePath1,
//         filePath2: filePath2,
//         filePath3: filePath3,
//         label: label);
//     if (res != null && res.statusCode != null && res.statusCode == 200) {
//       if (res.data['message'] == "Dữ liệu khuôn mặt đã được lưu thành công") {
//         return BaseApiResponse(responseData: true, status: ApiStatus.Success);
//       } else {
//         return BaseApiResponse(
//             responseData: res.data['msg'], status: ApiStatus.Failed);
//       }
//     } else {
//       return BaseApiResponse(responseData: null, status: ApiStatus.Failed);
//     }
//   }

//   Future<dynamic> checkface({required String filePath1,  required String classID}) async {
//     var res = await api.checkface(inputImage: filePath1, classID: classID);
//     if (res != null && res.statusCode != null && res.statusCode == 200) {
//       return BaseApiResponse(responseData: true, status: ApiStatus.Success);
//     } else {
//       return BaseApiResponse(responseData: null, status: ApiStatus.Failed);
//     }
//   }

// }

import 'dart:async';
import 'package:findy/src/student/service/detectface_services.dart';
import 'package:findy/utils/model/api_response/base_api_response_model.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class SignUpRepositories {
  ApiDio api = ApiDio();

  //login
  Future<dynamic> postface(
      {required String filePath1,
      required String filePath2,
      required String filePath3,
      required String label}) async {
    var res = await api.postface(
        filePath1: filePath1,
        filePath2: filePath2,
        filePath3: filePath3,
        label: label);
    if (res != null && res.statusCode != null && res.statusCode == 200) {
      if (res.data['message'] == "Dữ liệu khuôn mặt đã được lưu thành công") {
        return BaseApiResponse(responseData: true, status: ApiStatus.Success);
      } else {
        return BaseApiResponse(
            responseData: res.data['message'], status: ApiStatus.Failed);
      }
    } else {
      return BaseApiResponse(responseData: null, status: ApiStatus.Failed);
    }
  }

  Future<dynamic> checkface(
      {required String filePath1, required String classID,required String beginTime,required String endTime}) async {
    var res = await api.checkface(filePath1: filePath1, classID: classID,  beginTime: beginTime,endTime: endTime);
    if (res != null && res.statusCode != null) {
      if (res.statusCode == 200) {
        CustomSnackbar.snackbarSuccess("Bạn đã checkin/out thành công");
        return BaseApiResponse(responseData: true, status: ApiStatus.Success);
      } else {
        CustomSnackbar.snackbarSuccess(res.data['message']);
        return BaseApiResponse(
            responseData: res.data['message'], status: ApiStatus.Failed);
      }
    } else {
      return BaseApiResponse(responseData: null, status: ApiStatus.Failed);
    }
  }
}
