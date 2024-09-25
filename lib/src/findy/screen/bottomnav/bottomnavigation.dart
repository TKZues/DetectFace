import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/screen/home/home.dart';
import 'package:findy/src/findy/screen/menu/menu.dart';
import 'package:findy/src/findy/screen/social/social_screen.dart';
import 'package:findy/src/findy/screen/timeline/timeline.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

class BottomNavigationApp extends StatefulWidget {
  const BottomNavigationApp({super.key});

  @override
  State<BottomNavigationApp> createState() => _BottomNavigationAppState();
}

class _BottomNavigationAppState extends State<BottomNavigationApp> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    int indexpage = 0;

    void onItemTab(int index) {
      setState(() {
        indexpage = index;
        pageController.jumpToPage(indexpage);
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            indexpage = value;
          });
        },
        controller: pageController,
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
        currentIndex: indexpage,
        onTap: onItemTab,
      ),
    );
  }

  Widget home() {
    return const HomeApp();
  }

  Widget menu() {
    return const MenuApp();
  }

  Widget timeline() {
    return  const TimeLineApp();
  }

  Widget social() {
    return  const CarouselWithIndicatorDemo();
  }
}
