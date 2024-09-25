import 'package:findy/checkin_background.dart';
import 'package:findy/constant/color.dart';
import 'package:findy/splash_screen.dart';
import 'package:findy/src/findy/screen/bottomnav/bottomnavigation.dart';
import 'package:findy/src/findy/screen/login/login_screen.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/initprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// ignore: non_constant_identifier_names
bool isSmallDevice = false;
bool isLargeDevice = false;
String baseUrl = "https://5caa-123-25-190-41.ngrok-free.app";
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
// ignore: non_constant_identifier_names
final Logger AppLogger = Logger(
  level: Level.info,
  filter: ReleaseFilter(),
);

class ReleaseFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterDownloader.initialize(
    debug: true,
  );

  runApp(const MyAppProvider());
}

class MyAppProvider extends StatelessWidget {
  const MyAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...AppCCVC.initProvider()],
      child: const FindyApp(),
    );
  }
}

class FindyApp extends StatefulWidget {
  // ignore: use_super_parameters
  const FindyApp({Key? key}) : super(key: key);

  @override
  State<FindyApp> createState() => _FindyAppState();
}

class _FindyAppState extends State<FindyApp> {
  String route = "/";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      // title: 'iVMS',
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      // navigatorKey: navigatorKey,
      localizationsDelegates: const [
        SfGlobalLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
      ],
      initialRoute: route,
      theme: ThemeData(
        primaryColor: AppColor.blueMain,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/scan_qr': (context) => const CheckinBackground(),
        '/scan_face': (context) => const LoginScreen(),
        '/bottom': (context) => const BottomNavigationApp(),
      },
    );
  }
}
