import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/student/model/blog_model.dart';
import 'package:findy/src/student/service/itemblog_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class ItemBlogRepositories extends BaseRepository<ItemBlogService> {
  ItemBlogRepositories(super.service);

  // final List<itemblogModel> _itemblogList = [];
  // List<itemblogModel> get itemblogList => _itemblogList;

  final List<BlogModel> _blogList = [];
  List<BlogModel> get blogList => _blogList;


  Future<void> getblog() async {
    startLoading();
    try {
      final res = await service.getblog();
      if (res.statusCode != 200) {
        _blogList.clear();
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _blogList.clear();
        for (final item in res.data) {
          final blog = BlogModel.fromJson(item);
          _blogList.add(blog);
        }
      } else {
        _blogList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
      }
      finishLoading();
    } on DioError catch (error) {
      _blogList.clear();
      _error(error.message.toString());
    } catch (error) {
      _blogList.clear();
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
