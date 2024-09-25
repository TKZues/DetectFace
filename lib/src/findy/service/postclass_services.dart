import 'package:dio/dio.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';

class PostClassService extends BaseService {
  PostClassService(Dio client) : super(client);

  Future<Response> getpost({required String classID}) async {
    return client.get(
      "$baseUrl/api/posts/posts/class/$classID",
    );
  }
}
