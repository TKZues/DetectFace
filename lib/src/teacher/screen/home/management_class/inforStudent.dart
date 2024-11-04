import 'package:findy/constant/color.dart';
import 'package:findy/src/teacher/repositories/chart_repositories.dart';
import 'package:findy/src/teacher/screen/home/attendance_history/today_attendence.dart';
import 'package:findy/src/teacher/screen/home/management_report/management_report.dart';
import 'package:findy/src/teacher/screen/home/management_statictis/chart/solandiemdanhtheotuan/bar%20chart/bar_charts.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../utils/config/size_config.dart';
import '../../../../../../../widget/text/textcustom.dart';
import '../../../../../widget/noitem/noitem.dart';

class InforStudent extends StatefulWidget {
  final String studentID;
  final String classID;
  const InforStudent(
      {super.key, required this.studentID, required this.classID});

  @override
  State<InforStudent> createState() => _InforStudentState();
}

class _InforStudentState extends State<InforStudent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<ChartRepositories1>();
      repo.reportchuyencanstudent(widget.studentID, widget.classID, DateFormat("dd-MM-yyyy").format(DateTime.now()));
      repo.checkinsumarystudent(widget.studentID, widget.classID,DateFormat("dd-MM-yyyy").format(DateTime.now()) );
      repo.getinoutinclass(widget.classID, widget.studentID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<ChartRepositories1>(),
      child: ProgressHUD(
        child: Scaffold(
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
          ),
          body: ConsumerBase<ChartRepositories1>(
            onRepository: (repository) {
              final List<ChartColumnData> chartData =
                            <ChartColumnData>[
                          ChartColumnData("Mo", repository.totalSubjects,
                              repository.checkedInCount),
                        ];
              return Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: AppColor.textDefault,
                    labelColor: AppColor.textDefault,
                    tabs: [
                      Tab(text: "Thông Tin"),
                      Tab(text: "Tuỳ Chọn"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Student information tab
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              // Dropdown để chọn tuần
                              Container(
                                width: double.infinity,
                                height: 40,
                                color: Colors.grey[300],
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 30,
                                      child: Text('STT',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Text('Tên lớp',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: psWidth(50),
                                      alignment: Alignment.center,
                                      child: Text('Tổng',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: psWidth(50),
                                      alignment: Alignment.center,
                                      child: Text('Học',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: psWidth(50),
                                      alignment: Alignment.center,
                                      child: Text('Nghỉ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: psWidth(50),
                                      alignment: Alignment.center,
                                      child: Text('Muộn',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      width: psWidth(50),
                                      alignment: Alignment.center,
                                      child: Text('Điểm',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              // Table Body
                              SizedBox(
                                height: psHeight(
                                    80), // Set a fixed height for the ListView
                                child: ListView.builder(
                                  itemCount: repository.listDiemchuyencan.length,
                                  itemBuilder: (context, index) {
                                    return TableRow1(
                                        index: index,
                                        scoreitem: repository.listDiemchuyencan[
                                            index]); // Pass the team object
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                TextCustom(
                                                  text:
                                                      'Biểu đồ số lần điểm danh theo ngày',
                                                  fontSize: psHeight(16),
                                                  fontWeight: FontWeight.bold,
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                    SfCartesianChart(
                                      margin: const EdgeInsets.all(10),
                                      borderWidth: 0,
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(isVisible: true),
                                      primaryYAxis: CategoryAxis(
                                          isVisible: true,
                                          minimum: 0,
                                          maximum: 5,
                                          interval: 1),
                                      series: <CartesianSeries>[
                                        ColumnSeries<ChartColumnData, String>(
                                            dataSource: chartData,
                                            width: 0.8,
                                            color: Color(0xFF2FEA9B),
                                            xValueMapper:
                                                (ChartColumnData data, _) =>
                                                    data.x,
                                            yValueMapper:
                                                (ChartColumnData data, _) =>
                                                    data.y),
                                        ColumnSeries<ChartColumnData, String>(
                                            dataSource: chartData,
                                            width: 0.8,
                                            color: Color(0xFFFFBF1A),
                                            xValueMapper:
                                                (ChartColumnData data, _) =>
                                                    data.x,
                                            yValueMapper:
                                                (ChartColumnData data, _) =>
                                                    data.y1)
                                      ],
                                    ),
                                    SizedBox(
                                      height: psHeight(20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 30,
                                              color: Color(0xFF2FEA9B),
                                            ),
                                            SizedBox(
                                              width: psWidth(10),
                                            ),
                                            TextCustom(
                                              text: "Số môn học hôm nay",
                                              fontSize: psHeight(12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 30,
                                              color: Color(0xFFFFBF1A),
                                            ),
                                            SizedBox(
                                              width: psWidth(10),
                                            ),
                                            TextCustom(
                                              text: "Số môn đã checkin",
                                              fontSize: psHeight(12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: psHeight(20),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                TextCustom(
                                                    text:
                                                        'Biểu đồ số lần điểm danh theo tuần',
                                                    fontSize: psHeight(18),
                                                    fontWeight: FontWeight.bold)
                                              ],
                                            )),
                                      ],
                                    ),
                                    SfCartesianChart(
                                      margin: const EdgeInsets.all(10),
                                      borderWidth: 0,
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(isVisible: true),
                                      primaryYAxis: CategoryAxis(
                                          isVisible: true,
                                          minimum: 0,
                                          maximum: 5,
                                          interval: 1),
                                      series: <CartesianSeries>[
                                        ColumnSeries<ChartColumnDataweek, String>(
                                            dataSource: repository
                                                .listChartColumnDataweek,
                                            width: 0.8,
                                            color: Color(0xFF967CFD),
                                            xValueMapper:
                                                (ChartColumnDataweek data, _) =>
                                                    data.x,
                                            yValueMapper:
                                                (ChartColumnDataweek data, _) =>
                                                    data.y),
                                        ColumnSeries<ChartColumnDataweek, String>(
                                            dataSource: repository
                                                .listChartColumnDataweek,
                                            width: 0.8,
                                            color: Color(0xFFFF4080),
                                            xValueMapper:
                                                (ChartColumnDataweek data, _) =>
                                                    data.x,
                                            yValueMapper:
                                                (ChartColumnDataweek data, _) =>
                                                    data.y1)
                                      ],
                                    ),
                                    SizedBox(
                                      height: psHeight(20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 30,
                                              color: Color(0xFF967CFD),
                                            ),
                                            SizedBox(
                                              width: psWidth(10),
                                            ),
                                            TextCustom(
                                              text: "Số môn học",
                                              fontSize: psHeight(12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 30,
                                              color: Color(0xFFFF4080),
                                            ),
                                            SizedBox(
                                              width: psWidth(10),
                                            ),
                                            TextCustom(
                                              text: "Số môn checkin",
                                              fontSize: psHeight(12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                itemCount: repository.listDiemchuyencan.length,
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // Disable scrolling for the GridView
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: psHeight(1),
                                  mainAxisSpacing: psHeight(1),
                                  mainAxisExtent: psHeight(300),
                                ),
                                itemBuilder: (context, index) {
                                  String title = repository
                                          .listDiemchuyencan[index].className ??
                                      "";
                                  int totalCheckIns = repository
                                          .listDiemchuyencan[index]
                                          .totalCheckIns ??
                                      0;
                                  int totalAbsences = repository
                                          .listDiemchuyencan[index]
                                          .totalAbsences ??
                                      0;
                                  int totalLate = repository
                                          .listDiemchuyencan[index].totalLate ??
                                      0;
                          
                                  List<AttendanceStatus> weeklyData = [
                                    AttendanceStatus('Có mặt',
                                        totalCheckIns.toDouble(), Colors.green),
                                    AttendanceStatus('Vắng mặt',
                                        totalAbsences.toDouble(), Colors.red),
                                    AttendanceStatus('Đi muộn',
                                        totalLate.toDouble(), Colors.orange),
                                  ];
                          
                                  return SfCircularChart(
                                    title: ChartTitle(text: title),
                                    legend: Legend(isVisible: true),
                                    series: <CircularSeries>[
                                      PieSeries<AttendanceStatus, String>(
                                        dataSource: weeklyData,
                                        xValueMapper:
                                            (AttendanceStatus status, _) =>
                                                status.status,
                                        yValueMapper:
                                            (AttendanceStatus status, _) =>
                                                status.percentage,
                                        dataLabelMapper: (AttendanceStatus status,
                                                _) =>
                                            '${status.status}: ${status.percentage}%',
                                        pointColorMapper:
                                            (AttendanceStatus status, _) =>
                                                status.color,
                                        enableTooltip: true,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Placeholder for the second tab
                        _buildHistory(repository)
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

  Widget _buildHistory(ChartRepositories1 rp) {
    String checkInTime;
    String checkOutTime;
    int checkInLateMinutes;
    int checkOutLateMinutes;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: psHeight(5)),
          rp.attendancehistoryList.isEmpty
              ? const NoItem()
              : Expanded(
                  child: GridView.builder(
                    itemCount: rp.attendancehistoryList.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: psHeight(1),
                      mainAxisSpacing: psHeight(1),
                      mainAxisExtent: psHeight(330),
                    ),
                    itemBuilder: (context, index) {
                      checkInLateMinutes =
                          rp.attendancehistoryList[index].checkInLateMinutes ??
                              0;
                      checkOutLateMinutes =
                          rp.attendancehistoryList[index].checkOutLateMinutes ??
                              0;
                      if (rp.attendancehistoryList.isNotEmpty) {
                        if (rp.attendancehistoryList[index].checkInTime !=
                                null &&
                            rp.attendancehistoryList[index].checkInTime!
                                .isNotEmpty) {
                          DateTime checkintime = DateTime.parse(
                              rp.attendancehistoryList[index].checkInTime!);
                          checkInTime = DateFormat.Hms().format(checkintime);
                        } else {
                          checkInTime = "";
                        }

                        if (rp.attendancehistoryList[index].checkOutTime !=
                                null &&
                            rp.attendancehistoryList[index].checkOutTime!
                                .isNotEmpty) {
                          DateTime checkouttime = DateTime.parse(
                              rp.attendancehistoryList[index].checkOutTime!);
                          checkOutTime = DateFormat.Hms().format(checkouttime);
                        } else {
                          checkOutTime = "";
                        }
                      } else {
                        checkInTime = "";
                        checkOutTime = "";
                      }
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              text:
                                  rp.attendancehistoryList[index].subjectName ??
                                      "",
                              fontSize: psHeight(16),
                              color: AppColor.kGreen,
                              fontWeight: FontWeight.w700,
                            ),
                            Row(
                              children: [
                                TodayAttendenceCheckIn(
                                  title: "Check In",
                                  icon: Icons.input,
                                  description: "Thời gian check-in",
                                  iconbackground: const Color(0xFF79AF44),
                                  data: checkInTime,
                                ),
                                TodayAttendenceCheckIn(
                                  title: "Check Out",
                                  icon: Icons.output,
                                  description: "Thời gian check-out",
                                  iconbackground: AppColor.iconpink,
                                  data: checkOutTime,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TodayAttendenceCheckIn(
                                  title: "Checkin Muộn",
                                  icon: Icons.breakfast_dining,
                                  description: "Thời gian check-in muộn",
                                  iconbackground: AppColor.iconpurple,
                                  data: checkInLateMinutes.toString(),
                                ),
                                TodayAttendenceCheckIn(
                                  title: "Checkout Muộn",
                                  icon: Icons.calendar_month,
                                  description: "Thời gian check-out muộn",
                                  iconbackground: AppColor.iconbrown,
                                  data: checkOutLateMinutes.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class AttendanceStatus {
  final String status;
  final double percentage;
  final Color color;

  AttendanceStatus(this.status, this.percentage, this.color);
}
