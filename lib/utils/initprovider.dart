
import 'package:findy/src/findy/repositories/attendance_repositories.dart';
import 'package:findy/src/findy/repositories/itemblog_repositories.dart';
import 'package:findy/src/findy/repositories/login_repositories.dart';
import 'package:findy/src/findy/repositories/notification_repositories.dart';
import 'package:findy/src/findy/repositories/postclass_repositories.dart';
import 'package:findy/src/findy/repositories/timeline_repositories.dart';
import 'package:findy/src/findy/service/attendance_services.dart';
import 'package:findy/src/findy/service/itemblog_services.dart';
import 'package:findy/src/findy/service/login_services.dart';
import 'package:findy/src/findy/service/notification_services.dart';
import 'package:findy/src/findy/service/postclass_services.dart';
import 'package:findy/src/findy/service/timeline_services.dart';
import 'package:findy/utils/services/dio_option.dart';
import 'package:provider/provider.dart';

/// A Calculator.
class AppCCVC {
  static List initProvider() {
    final client = DioOption().createDio();
    return [
          ChangeNotifierProvider<NotificationRepositories>(create: (context) => NotificationRepositories(NotificationService(client)),),
           ChangeNotifierProvider<TimelineRepositories>(create: (context) => TimelineRepositories(TimelineServices(client)),),
           ChangeNotifierProvider<LoginRepositories>(create: (context) => LoginRepositories(LoginServices(client)),),
           ChangeNotifierProvider<AttendanceRepositories>(create: (context) => AttendanceRepositories(AttendanceServices(client)),),
           ChangeNotifierProvider<ItemBlogRepositories>(create: (context) => ItemBlogRepositories(ItemBlogService(client)),),
           ChangeNotifierProvider<PostClassRepositories>(create: (context) => PostClassRepositories(PostClassService(client)),)
    ];
  }
}
