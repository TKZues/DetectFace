import 'dart:async';
import 'dart:math';

import 'package:findy/constant/color.dart';
import 'package:findy/src/teacher/screen/home/attendance_history/attendance_history_screen.dart';
import 'package:findy/src/teacher/screen/home/item_home.dart';
import 'package:findy/src/teacher/screen/home/management_class/management_class_screen.dart';
import 'package:findy/src/teacher/screen/home/management_notification/notificationsocket_screen.dart';
import 'package:findy/src/teacher/screen/home/management_statictis/management_statictis_screen.dart';
import 'package:findy/src/teacher/screen/home/management_subject/classes_manage_screen.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    // ignore: unused_local_variable
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        title: TextCustom(
          text: "Trang cá nhân",
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const DigitalClockWidget(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextCustom(
                text: formattedDate,
                fontWeight: FontWeight.w300,
                color: AppColor.aicamLoginBackgroud,
                fontSize: 20,
              ),
            ),
            ClockView(),
            SizedBox(height: psHeight(20),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
              child: Row(
                children: [
                  ItemHome(
                      title: "Quản lý điểm danh",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AttendanceHistory(),
                            ));
                      },
                      logo: "assets/images/qlynahndien.jpg"),
                  SizedBox(
                    width: psWidth(20),
                  ),
                  ItemHome(
                      title: "Quản lý lớp học",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ManagementClassScreen(),
                            ));
                      },
                      logo: "assets/images/nghiphep.jpg"),
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
                      title: "Thống kê",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ManagementStatictisScreen(),
                            ));
                      },
                      logo: "assets/images/thongke.jpg"),
                  SizedBox(
                    width: psWidth(20),
                  ),
                  ItemHome(
                      title: "Timesheets",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClassesManageScreen(),
                            ));
                      },
                      logo: "assets/images/timesheet.jpg"),
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
                      title: "Thông báo cảnh báo vi phạm",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationSocketScreen(),
                            ));
                      },
                      logo: "assets/images/thongbao.jpg"),
                  SizedBox(
                    width: psWidth(20),
                  ),
                  ItemHome(
                      title: "Báo cáo chuyên cần",
                      onTap: () {},
                      logo: "assets/images/chuyencan.jpg"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //60 sec - 360, 1 sec - 6degree
  //12 hours  - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = const Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = const Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = Color.fromARGB(255, 255, 203, 234)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DigitalClockWidgetState();
  }
}

class DigitalClockWidgetState extends State<DigitalClockWidget> {
  var formattedTime = DateFormat('HH:mm').format(DateTime.now());
  late Timer timer;

  @override
  void initState() {
    this.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var perviousMinute =
          DateTime.now().add(const Duration(seconds: -1)).minute;
      var currentMinute = DateTime.now().minute;
      if (perviousMinute != currentMinute)
        setState(() {
          formattedTime = DateFormat('HH:mm').format(DateTime.now());
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextCustom(
      text: formattedTime,
      fontWeight: FontWeight.w300,
      color: AppColor.aicamLoginBackgroud,
      fontSize: psHeight(50),
      textAlign: TextAlign.center,
    );
  }
}
