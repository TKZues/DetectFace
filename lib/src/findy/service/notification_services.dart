
import 'package:dio/dio.dart';
import 'package:findy/main.dart';
import 'package:findy/utils/services/base.dart';

class NotificationService extends BaseService {
  NotificationService(Dio client) : super(client);


  Future<Response> getNotification() async {
    return client.get("$baseUrl/api/notifications",);
  }

  Future<Response> getNotificationCount() async {
    return client.get("$baseUrl/api/notifications/count",);
  }
}

