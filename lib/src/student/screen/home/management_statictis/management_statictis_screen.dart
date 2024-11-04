import 'package:findy/src/student/screen/home/management_statictis/chart/linechart_thoigiancheckintrungbinh/thoigiancheckintrungbinh.dart';
import 'package:findy/src/student/screen/home/management_statictis/chart/linechart_xuhuongdiemdanh/xuhuongdiemdanh.dart';
import 'package:findy/src/student/screen/home/management_statictis/chart/pie_tyletrangthaidiemdanh/tyletrangthaidiemdanh.dart';
import 'package:findy/src/student/screen/home/management_statictis/chart/solandiemdanhtheotuan/bar%20chart/bar_charts.dart';
import 'package:findy/src/student/screen/home/item_home.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';

class ManagementStatictisScreen extends StatelessWidget {
  const ManagementStatictisScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        leading: GFIconButton(
          icon: Container(
            padding: EdgeInsets.symmetric(
                horizontal: psWidth(3), vertical: psHeight(4)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(psHeight(4)),
              color: AppColor.backgbackColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.backiconColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          type: GFButtonType.transparent,
        ),
        title: TextCustom(
          text: "Thống kê",
          color: AppColor.textDefault,
          fontSize: psHeight(16),
        ),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.favorite,
              color: AppColor.textDefault,
              size: psHeight(16),
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
              child: Row(
                children: [
                  ItemHome(
                      title: "Số lần điểm danh theo tuần/tháng",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BarCharts(),
                            ));
                      },
                      logo: "assets/images/diemdanh.png"),
                ],
              ),
            ),
            SizedBox(
              height: psHeight(20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
              child: Row(
                children: [
                  ItemHome(
                      title: "Thời gian check-in trung bình",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Thoigiancheckintrungbinh(),
                            ));
                      },
                      logo: "assets/images/timetrunbinh.png"),
                ],
              ),
            ),
            SizedBox(
              height: psHeight(20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
              child: Row(
                children: [
                  ItemHome(
                      title: "Tỷ lệ trạng thái điểm danh",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Tyletrangthaidiemdanh(),
                            ));
                      },
                      logo: "assets/images/status.jpg"),
                ],
              ),
            ),
            SizedBox(
              height: psHeight(20),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
              child: Row(
                children: [
                  ItemHome(
                      title: "Xu hướng điểm danh theo thời gian",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const XuhuongdiemdanhScreen(),
                            ));
                      },
                      logo: "assets/images/promote.png"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
