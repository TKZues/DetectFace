import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/model/statistic_model.dart';
import 'package:findy/src/findy/repositories/notification_repositories.dart';
import 'package:findy/src/findy/screen/menu/achievement/level_achievement.dart';
import 'package:findy/src/findy/screen/menu/achievement/medal_achievement.dart';
import 'package:findy/src/findy/screen/menu/information/contact_information.dart';
import 'package:findy/src/findy/screen/menu/information/course_information.dart';
import 'package:findy/src/findy/screen/menu/information/general_information.dart';
import 'package:findy/src/findy/screen/menu/stat/card_menu.dart';
import 'package:findy/src/findy/screen/menu/stat/notification_general.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MenuApp extends StatefulWidget {
  const MenuApp({super.key});

  @override
  State<MenuApp> createState() => _MenuAppState();
}

class _MenuAppState extends State<MenuApp> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<NotificationRepositories>();
      // repo.getNotification();
      repo.getNotificationCount();
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
          backgroundColor: Colors.grey[200],
          appBar: GFAppBar(
            backgroundColor: AppColor.appbarColor,
            centerTitle: true,
            title: TextCustom(
              text: "Menu",
              color: Colors.white,
              fontSize: psHeight(16),
            ),
            actions: <Widget>[
              GFIconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
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
                  SizedBox(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              "assets/images/avatar.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          const Text(
                            "Aria Muller",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: 'CHUNG'),
                      Tab(text: 'THÀNH TỰU'),
                      Tab(text: 'THÔNG TIN'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _tabSTATS(rp),
                        _tabACHIEVEMENT(),
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
    List chartdata = [
      [6, "Chưa tích lũy", const Color.fromRGBO(123, 201, 82, 1)],
      [115, "Đã tích lũy", const Color.fromRGBO(255, 171, 61, 1)]
    ];

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationGeneral(),));
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
                  gradientcolor2: const Color(0xFFEDB13E),
                ),
              ],
            ),
            const Text(
              "Tiến độ học tập",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SfCircularChart(
              series: [
                PieSeries(
                    dataSource: chartdata,
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
              "Kết quả học tập",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SfCartesianChart(
              title: ChartTitle(text: 'Điểm trung bình'),
              primaryXAxis: CategoryAxis(
                isVisible: true,
              ),
              primaryYAxis: NumericAxis(
                  // labelFormat: '{value}M',
                  title: AxisTitle(text: 'Điểm trung bình'),
                  //đường line của bar
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(size: 0)),
              series: <ChartSeries<ChartSampleData, String>>[
                ColumnSeries<ChartSampleData, String>(
                  onCreateRenderer:
                      (ChartSeries<ChartSampleData, String> series) =>
                          CustomColumnSeriesRenderer(),
                  dataLabelSettings: const DataLabelSettings(
                      //có hiện chữ không
                      isVisible: true,
                      //chữ trong cái cột giữa, trên, dưới
                      labelAlignment: ChartDataLabelAlignment.middle),
                  dataSource: <ChartSampleData>[
                    ChartSampleData(x: 'TTTBDD', y: 8),
                    ChartSampleData(x: 'Thực hành', y: 9),
                    ChartSampleData(x: 'Testing', y: 7.8),
                    ChartSampleData(x: 'C#', y: 8.5),
                    ChartSampleData(x: 'Web', y: 9.2),
                  ],
                  width: 0.8,
                  xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                  yValueMapper: (ChartSampleData sales, _) => sales.y,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _tabACHIEVEMENT() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LevelAchievement(),
            TextCustom(
              text: "MEDALS",
              fontWeight: FontWeight.bold,
              color: Color(0xFF9098A3),
              fontSize: 15,
              paddingY: 4,
            ),
            Row(
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

