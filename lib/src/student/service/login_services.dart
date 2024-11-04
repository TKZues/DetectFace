import 'package:dio/dio.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';

class LoginServices extends BaseService {
  // ignore: use_super_parameters
  LoginServices(Dio client) : super(client);

  Future<Response> signup(
      {required String username,
      required String email,
      required String password}) async {
    Map<String, dynamic> params = {
      "username": username,
      "email": email,
      "password": password
    };
    return client.post("$baseUrl/api/user/register", data: params);
  }

  Future<Response> login(
      {required String email, required String password}) async {
    Map<String, dynamic> params = {"email": email, "password": password};
    return client.post("$baseUrl/api/user/login", data: params);
  }
}
