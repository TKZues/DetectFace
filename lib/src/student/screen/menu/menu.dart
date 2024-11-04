import 'package:findy/constant/color.dart';
import 'package:findy/constant/share_preference_key.dart';
import 'package:findy/src/student/repositories/notification_repositories.dart';
import 'package:findy/src/student/screen/menu/achievement/level_achievement.dart';
import 'package:findy/src/student/screen/menu/achievement/medal_achievement.dart';
import 'package:findy/src/student/screen/menu/information/contact_information.dart';
import 'package:findy/src/student/screen/menu/information/course_information.dart';
import 'package:findy/src/student/screen/menu/information/general_information.dart';
import 'package:findy/src/student/screen/menu/stat/card_menu.dart';
import 'package:findy/src/student/screen/menu/stat/notification_general.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/utils/socket/sockettimeline.dart';
import 'package:findy/widget/bottomsheet/bottomsheet.dart';
import 'package:findy/widget/button/buttoncustom.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MenuApp extends StatefulWidget {
  const MenuApp({super.key});

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController ctdt = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<NotificationRepositories>();
      // repo.getNotification();
      repo.getNotificationCount();
      repo.getStudentInfor();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<NotificationRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 250, 250, 250),
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
          body: ConsumerBase<NotificationRepositories>(
            onRepository: (rp) {
              return Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: psHeight(12),
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'Tiến độ'),
                      Tab(text: 'Thông báo'),
                      Tab(text: 'Thông tin'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _tabSTATS(rp),
                        _tabACHIEVEMENT(rp),
                        _tabACTIVITY(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _tabSTATS(NotificationRepositories repo) {
    List piedata = [
      [repo.inforStudentList[0].remainingCredits, "Chưa tích lũy", const Color.fromRGBO(123, 201, 82, 1)],
      [repo.inforStudentList[0].accumulatedCredits, "Đã tích lũy", const Color.fromRGBO(255, 171, 61, 1)]
    ];

    List chartdata = [
      [8, "C++", const Color(0xff2ECC71)],
      [9, "Flutter", const Color(0xff58D68D)],
      [7, "Testing", const Color(0xffF7DC6F)],
      [8, "C#", const Color(0xffF4D03F)],
      [9, "Phân tích thiết kế", const Color(0xffF0B27A)],
    ];

    List scoresdata = [
      [repo.inforStudentList[0].aPlus, "A+", const Color(0xff2ECC71)],
      [repo.inforStudentList[0].a, "A", const Color(0xff58D68D)],
      [repo.inforStudentList[0].bPlus, "B+", const Color(0xffF7DC6F)],
      [repo.inforStudentList[0].b, "B", const Color(0xffF4D03F)],
      [repo.inforStudentList[0].cPlus, "C+", const Color(0xffF28E1C)],
      [repo.inforStudentList[0].c, "C", const Color(0xffE96220)],
      [repo.inforStudentList[0].ePlus, "E+", const Color.fromARGB(255, 251, 60, 7)],
      [repo.inforStudentList[0].e, "E", const Color(0xffE32322)],
    ];


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              text: "THÔNG TIN CƠ BẢN",
              fontSize: psHeight(16),
              fontWeight: FontWeight.bold,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _item("Mã sinh viên: ", repo.inforStudentList[0].id??""),
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _item("Họ tên: ", repo.inforStudentList[0].name??""),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _item("Giới tính: ", repo.inforStudentList[0].gender??""),
                    _item("Lớp: ", repo.inforStudentList[0].classes??""),
                    _item("Khóa học: ", repo.inforStudentList[0].course??""),
                  ],
                ),
                SizedBox(
                  height: psHeight(10),
                ),
                BottomSheetCustom(
                  RoadTextEditingController: ctdt,
                  label: "Chương trình đào tạo",
                ),
                Row(
                  children: [
                    Expanded(
                      child: BottomSheetCustom(
                        RoadTextEditingController: ctdt,
                        label: "Năm học",
                      ),
                    ),
                    SizedBox(
                      width: psWidth(10),
                    ),
                    Expanded(
                        child: BottomSheetCustom(
                      RoadTextEditingController: ctdt,
                      label: "Học kỳ",
                    )),
                  ],
                )
              ],
            ),
            SizedBox(
              height: psHeight(10),
            ),
             const Text(
              "Kết quả học tập",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SfCartesianChart(
              title: ChartTitle(text: 'Kết quả học tập'),
              primaryXAxis: CategoryAxis(
                isVisible: true,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Điểm trung bình'),
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
              ),
              series: <ChartSeries>[
                ColumnSeries(
                  dataSource: chartdata, // Your data
                  xValueMapper: (data, _) =>
                      data[1], // The x-axis (e.g., subjects)
                  yValueMapper: (data, _) =>
                      data[0], // The y-axis (e.g., scores)
                  pointColorMapper: (data, _) =>
                      data[2], // This might return dynamic instead of Color

                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(fontSize: 12),
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                ),
              ],
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
            ),
            const Text(
              "Tiến độ học tập",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SfCircularChart(
              series: [
                PieSeries(
                    dataSource: piedata,
                    yValueMapper: (data, _) => data[0],
                    xValueMapper: (data, _) => data[1],
                    radius: "80%",
                    explode: true,
                    pointColorMapper: (data, _) => data[2],
                    dataLabelMapper: (data, _) => "${data[0]}K",
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 12),
                        labelPosition: ChartDataLabelPosition.outside))
              ],
              legend: Legend(isVisible: true, position: LegendPosition.top),
            ),
             const Text(
              "Thống kê điểm sinh viên theo thang điểm",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                isVisible: true,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Số lượng'),
                majorGridLines: const MajorGridLines(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
              ),
              series: <ChartSeries>[
                ColumnSeries(
                  dataSource: scoresdata, // Your data
                  xValueMapper: (data, _) =>
                      data[1], // The x-axis (e.g., subjects)
                  yValueMapper: (data, _) =>
                      data[0], // The y-axis (e.g., scores)
                  pointColorMapper: (data, _) =>
                      data[2], // This might return dynamic instead of Color

                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(fontSize: 12),
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                ),
              ],
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ButtonCustom(
                title: "Đăng xuất",
                colorbtn: AppColor.btncheckin,
                colortitle: AppColor.kGreen,
                onTap: ()  async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.remove(SharePreferenceKeys.userID);
                  SocketTimeline.instance
                                    .disconnectFromSocketIvms();
                  Navigator.pushNamedAndRemoveUntil(context, '/scan_face', (route) => false);

                },
                paddingX: 100,
                paddingY: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String infor) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 197, 197, 197), width: 1))),
      child: Padding(
        padding: EdgeInsets.all(psHeight(8)),
        child: Row(
          children: [
            TextCustom(
              text: title,
              fontSize: psHeight(11),
            ),
            TextCustom(
              text: infor,
              fontSize: psHeight(11),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabACHIEVEMENT(NotificationRepositories repo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CardMenu(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationGeneral(),
                        ));
                  },
                  icon: Icons.flash_on_outlined,
                  number: repo.notificationcount.toString(),
                  title: "Thông báo",
                  gradientcolor1: const Color(0xFFFFBF1A),
                  gradientcolor2: const Color(0xFFFF4080),
                ),
                const SizedBox(width: 10),
                CardMenu(
                  onTap: () {},
                  icon: Icons.dashboard,
                  number: "#2",
                  title: "Leaderboard",
                  gradientcolor1: const Color(0xFF967CFD),
                  gradientcolor2: const Color(0xFF3177FF),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CardMenu(
                  onTap: () {},
                  icon: Icons.check,
                  number: "83%",
                  title: "Accuracy",
                  gradientcolor1: const Color(0xFF2FEA9B),
                  gradientcolor2: const Color(0xFF7FDD53),
                ),
                const SizedBox(width: 10),
                CardMenu(
                  onTap: () {},
                  icon: Icons.developer_board,
                  number: "86%",
                  title: "Recall",
                  gradientcolor1: const Color(0xFF52D060),
                  gradientcolor2: const Color(0xFF5470C6),
                ),
              ],
            ),
            const LevelAchievement(),
            const TextCustom(
              text: "MEDALS",
              fontWeight: FontWeight.bold,
              color: Color(0xFF9098A3),
              fontSize: 15,
              paddingY: 4,
            ),
            const Row(
              children: [
                MedalAchievement(
                  gradientcolor1: Color(0xFFFFE092),
                  gradientcolor2: Color(0xFFE3A302),
                  title: "Gold",
                  number: 24,
                ),
                MedalAchievement(
                  gradientcolor1: Color(0xFFB6C0D6),
                  gradientcolor2: Color(0xFF6B6A7B),
                  title: "Silver",
                  number: 18,
                ),
                MedalAchievement(
                  gradientcolor1: Color(0xFF97766F),
                  gradientcolor2: Color(0xFFDACFB3),
                  title: "Bronze",
                  number: 11,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _tabACTIVITY() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GeneralInformation(
                title: "THÔNG TIN CHUNG",
                mssv: "2121012280",
                name: "Ngô Nguyễn Tuấn Kiệt",
                birth: "14/06/2003",
                gender: "Nam",
                cccd: "052203014587",
                lop: "21DTH3"),
            SizedBox(
              height: psHeight(20),
            ),
            const CourseInformation(
                title: "THÔNG TIN KHÓA HỌC",
                course: "Khóa 21D",
                type: "Chính quy",
                person: "",
                phone: ""),
            SizedBox(
              height: psHeight(20),
            ),
            const ContactInformation(
                title: "THÔNG TIN LIÊN LẠC",
                dantoc: "Kinh",
                tongiao: "Không",
                quocgia: "Vietnam",
                tinhthanh: "Tỉnh Bình Định",
                quanhuyen: "Huyện Tuy Phước",
                didong: "0358857674")
          ],
        ),
      ),
    );
  }
}
