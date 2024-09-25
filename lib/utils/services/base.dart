import 'package:dio/dio.dart';

abstract class BaseService {
  final Dio client;

  BaseService(this.client);
}
