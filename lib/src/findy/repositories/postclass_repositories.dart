import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/findy/model/postclass_model.dart';
import 'package:findy/src/findy/service/postclass_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class PostClassRepositories extends BaseRepository<PostClassService> {
  PostClassRepositories(super.service);

  final List<PostClassModel> _postclassList = [];
  List<PostClassModel> get postclassList => _postclassList;


  Future<void> getpost(String classID) async {
    startLoading();
    try {
      final res = await service.getpost(classID: classID);
      if (res.statusCode != 200) {
        _postclassList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _postclassList.clear();
        for (final item in res.data['posts']) {
          final notificationItem = PostClassModel.fromJson(item);
          _postclassList.add(notificationItem);
        }
      } else {
        _postclassList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _postclassList.clear();
      _error(error.message.toString());
    } catch (error) {
      _postclassList.clear();
      _error(error.toString());
    }
  }

  _error(String message) {
    finishLoading();
    errorMessage = message.toString();
    if (message.isNotEmpty) {
      CustomSnackbar.snackbarError(message);
    }
  }
}
