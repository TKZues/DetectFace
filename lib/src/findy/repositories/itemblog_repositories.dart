import 'dart:async';
import 'package:dio/dio.dart';
import 'package:findy/src/findy/model/blog_model.dart';
import 'package:findy/src/findy/model/itemblog_model.dart';
import 'package:findy/src/findy/service/itemblog_services.dart';
import 'package:findy/utils/repository/base.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';

class ItemBlogRepositories extends BaseRepository<ItemBlogService> {
  ItemBlogRepositories(super.service);

  final List<itemblogModel> _itemblogList = [];
  List<itemblogModel> get itemblogList => _itemblogList;

  final List<BlogModel> _blogList = [];
  List<BlogModel> get blogList => _blogList;


  Future<void> getitemBlog() async {
    startLoading();
    try {
      final res = await service.getitemBlog();
      if (res.statusCode != 200) {
        _itemblogList.clear();
        CustomSnackbar.snackbarError(res.data['message']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _itemblogList.clear();
        for (final item in res.data) {
          final itemblog = itemblogModel.fromJson(item);
          _itemblogList.add(itemblog);
        }
      } else {
        _itemblogList.clear();
        CustomSnackbar.snackbarError(res.data['msg']);
      }
      finishLoading();
    } on DioError catch (error) {
      _itemblogList.clear();
      _error(error.message.toString());
    } catch (error) {
      _itemblogList.clear();
      _error(error.toString());
    }
  }

  Future<void> getblog(String id) async {
    startLoading();
    try {
      final res = await service.getblog(blogTypeID: id);
      if (res.statusCode != 200) {
        _blogList.clear();
        CustomSnackbar.snackbarError(res.data['data']);
        finishLoading();
        return;
      }
      if (res.statusCode == 200) {
        _blogList.clear();
        for (final item in res.data['data']) {
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
