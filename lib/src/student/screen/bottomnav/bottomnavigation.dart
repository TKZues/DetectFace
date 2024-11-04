import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/timeline_repositories.dart';
import 'package:findy/src/student/screen/home/clock/screens/home_screen.dart';
import 'package:findy/src/student/screen/menu/menu.dart';
import 'package:findy/src/student/screen/social/screens/home_screen.dart';
import 'package:findy/src/student/screen/timeline/timeline.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/socket/sockettimeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationApp extends StatefulWidget {
  const BottomNavigationApp({super.key});

  @override
  State<BottomNavigationApp> createState() => _BottomNavigationAppState();
}

class _BottomNavigationAppState extends State<BottomNavigationApp> {

  Future<void> initializeSockets() async {
    await SocketTimeline.instance.initializeSocketWithTokenIvmsmotion();
    SocketTimeline.instance.connectSocketIvms();

    // ignore: use_build_context_synchronously
    // ignore: use_build_context_synchronously
    SocketTimeline.instance.webSocketMotionReceiverIvms(
      // ignore: use_build_context_synchronously
      context,
      "notify",
      (data) => context
          .read<TimelineRepositories>()
          .handleSocketDataCamStatus(context, data),
    );
  }
  late PageController _pageController;
  int _indexPage = 0;

  @override
  void initState() {
    super.initState();
    initializeSockets();
    _pageController = PageController(); // Initialize the PageController here
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the PageController when the widget is destroyed
    super.dispose();
  }

  void onItemTab(int index) {
    setState(() {
      _indexPage = index;
    });
    _pageController.jumpToPage(index); // Use the controller to jump to the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController, // Use the controller
        onPageChanged: (value) {
          setState(() {
            _indexPage = value;
          });
        },
        children: [home(), timeline(), social(), menu()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 30,
        selectedItemColor: AppColor.aicamLoginBackgroud,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: psWidth(20),
        selectedIconTheme: IconThemeData(size: psWidth(24)),
        selectedFontSize: psWidth(12),
        unselectedFontSize: psWidth(12),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
              color: AppColor.aicamLoginBackgroud,
            ),
            label: "Trang chủ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timelapse_outlined,
            ),
            activeIcon: Icon(
              Icons.timelapse_outlined,
              color: AppColor.aicamLoginBackgroud,
            ),
            label: "Thời gian biểu",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.social_distance,
            ),
            activeIcon: Icon(
              Icons.social_distance,
              color: AppColor.aicamLoginBackgroud,
            ),
            label: "Confession",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            activeIcon: Icon(
              Icons.menu,
              color: AppColor.aicamLoginBackgroud,
            ),
            label: "Menu",
          )
        ],
        currentIndex: _indexPage,
        onTap: onItemTab, // Call onItemTab on tap
      ),
    );
  }

  Widget home() {
    return  const HomeScreen();
  }

  Widget menu() {
    return const MenuApp();
  }

  Widget timeline() {
    return const TimeLineApp();
  }

  Widget social() {
    return const SocialScreen();
  }
}

