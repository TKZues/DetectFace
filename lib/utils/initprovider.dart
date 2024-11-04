
import 'package:findy/src/student/repositories/attendance_repositories.dart';
import 'package:findy/src/student/repositories/chart_repositories.dart';
import 'package:findy/src/student/repositories/detectfacelive_repositories.dart';
import 'package:findy/src/student/repositories/itemblog_repositories.dart';
import 'package:findy/src/student/repositories/login_repositories.dart';
import 'package:findy/src/student/repositories/notification_repositories.dart';
import 'package:findy/src/student/repositories/postclass_repositories.dart';
import 'package:findy/src/student/repositories/timeline_repositories.dart';
import 'package:findy/src/student/screen/home/clock/models/my_theme_provider.dart';
import 'package:findy/src/student/service/attendance_services.dart';
import 'package:findy/src/student/service/chart_services.dart';
import 'package:findy/src/student/service/detectfacelive_service.dart';
import 'package:findy/src/student/service/itemblog_services.dart';
import 'package:findy/src/student/service/login_services.dart';
import 'package:findy/src/student/service/notification_services.dart';
import 'package:findy/src/student/service/postclass_services.dart';
import 'package:findy/src/student/service/timeline_services.dart';

import 'package:findy/src/teacher/repositories/attendance_repositories.dart';
import 'package:findy/src/teacher/repositories/chart_repositories.dart';
import 'package:findy/src/teacher/repositories/detectfacelive_repositories.dart';
import 'package:findy/src/teacher/repositories/itemblog_repositories.dart';
import 'package:findy/src/teacher/repositories/login_repositories.dart';
import 'package:findy/src/teacher/repositories/notification_repositories.dart';
import 'package:findy/src/teacher/repositories/postclass_repositories.dart';
import 'package:findy/src/teacher/repositories/timeline_repositories.dart';
import 'package:findy/src/teacher/screen/home/clock/models/my_theme_provider.dart';
import 'package:findy/src/teacher/service/attendance_services.dart';
import 'package:findy/src/teacher/service/chart_services.dart';
import 'package:findy/src/teacher/service/detectfacelive_service.dart';
import 'package:findy/src/teacher/service/itemblog_services.dart';
import 'package:findy/src/teacher/service/login_services.dart';
import 'package:findy/src/teacher/service/notification_services.dart';
import 'package:findy/src/teacher/service/postclass_services.dart';
import 'package:findy/src/teacher/service/timeline_services.dart';
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
           ChangeNotifierProvider<PostClassRepositories>(create: (context) => PostClassRepositories(PostClassService(client)),),
           ChangeNotifierProvider<ChartRepositories>(create: (context) => ChartRepositories(ChartServices(client)),),
           ChangeNotifierProvider(create: (context) => MyThemeModel()),
           ChangeNotifierProvider<DetectFaceLiveRepositories>(create: (context) => DetectFaceLiveRepositories(DetectFaceLiveService(client)),),

           ChangeNotifierProvider<NotificationRepositories1>(create: (context) => NotificationRepositories1(NotificationService1(client)),),
           ChangeNotifierProvider<TimelineRepositories1>(create: (context) => TimelineRepositories1(TimelineServices1(client)),),
           ChangeNotifierProvider<LoginRepositories1>(create: (context) => LoginRepositories1(LoginServices1(client)),),
           ChangeNotifierProvider<AttendanceRepositories1>(create: (context) => AttendanceRepositories1(AttendanceServices1(client)),),
           ChangeNotifierProvider<ItemBlogRepositories1>(create: (context) => ItemBlogRepositories1(ItemBlogService1(client)),),
           ChangeNotifierProvider<PostClassRepositories1>(create: (context) => PostClassRepositories1(PostClassService1(client)),),
           ChangeNotifierProvider<ChartRepositories1>(create: (context) => ChartRepositories1(ChartServices1(client)),),
           ChangeNotifierProvider(create: (context) => MyThemeModel1()),
           ChangeNotifierProvider<DetectFaceLiveRepositories1>(create: (context) => DetectFaceLiveRepositories1(DetectFaceLiveService1(client)),)
    ];
  }
}
