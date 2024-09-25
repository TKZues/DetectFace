
import 'package:dio/dio.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';

class ItemBlogService extends BaseService {
  ItemBlogService(Dio client) : super(client);

  Future<Response> getitemBlog() async {
    return client.get("$baseUrl/api/itemblog",);
  }

    Future<Response> getblog({required String blogTypeID}) async {
    return client.get("$baseUrl/api/vblogs/blogType/$blogTypeID",);
  }
}

