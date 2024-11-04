import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/teacher/model/postclass_model.dart';
import 'package:findy/src/teacher/model/teacherclasssubject_model.dart';
import 'package:findy/src/teacher/service/postclass_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class PostClassRepositories1 extends BaseRepository<PostClassService1> {
  PostClassRepositories1(super.service);

  final List<PostClassModel> _postclassList = [];
  List<PostClassModel> get postclassList => _postclassList;

  final List<ClassModel> _teacherclassList = [];
  List<ClassModel> get teacherclass => _teacherclassList;

  // final List<TeacherSubjectModel> _teachersubjectList = [];
  // List<TeacherSubjectModel> get teachersubject => _teachersubjectList;

  // final List<TeacherStudentModel> _teacherstudentList = [];
  // List<TeacherStudentModel> get teacherstudent => _teacherstudentList;

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

  Future<void> getclassteacher() async {
    startLoading();
    try {
      final res = await service.getclassteacher();
      if (res.statusCode != 200) {
        _teacherclassList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _teacherclassList.clear();
        for (final item in res.data['classes']) {
          final teacherclass = ClassModel.fromJson(item);
          _teacherclassList.add(teacherclass);
        }
      } else {
        _teacherclassList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _teacherclassList.clear();
      _error(error.message.toString());
    } catch (error) {
      _teacherclassList.clear();
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
