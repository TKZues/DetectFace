
import 'package:dio/dio.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';

class ItemBlogService1 extends BaseService {
  // ignore: use_super_parameters
  ItemBlogService1(Dio client) : super(client);


    Future<Response> getblog() async {
    return client.get("$baseUrl/api/allvblogs",);
  }
}

