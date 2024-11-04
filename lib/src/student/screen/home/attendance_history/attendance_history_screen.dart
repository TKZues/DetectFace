import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/attendance_repositories.dart';
import 'package:findy/src/student/screen/home/attendance_history/today_attendence.dart';
import 'package:findy/src/student/screen/home/management_subject/classes_item.dart';
import 'package:findy/src/student/screen/scanlive/scan_background.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/provider_base.dart';
import 'package:findy/widget/noitem/noitem.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:findy/widget/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<AttendanceRepositories>();
      repo.getinout(DateFormat('dd-MM-yyyy').format(DateTime.now()));
      repo.getnoinout(DateFormat('dd-MM-yyyy').format(DateTime.now()));
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
      value: context.read<AttendanceRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          appBar: GFAppBar(
            backgroundColor: AppColor.appbarColor,
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
                text: "Quản lý nhận diện",
                color: AppColor.textDefault,
                fontSize: psHeight(16)),
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
          body: Column(
            children: [
              // Timeline that is shared across both tabs
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TimeLineCustom(
                  rp: context.read<AttendanceRepositories>(),
                ),
              ),
              // TabBar with two tabs
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Đã điểm danh'),
                  Tab(text: 'Chưa điểm danh'),
                ],
                labelColor: AppColor.kGreen,
                unselectedLabelColor: Colors.black,
              ),
              // TabBarView to show content for each tab
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // First Tab: Attendance Data
                    Builder(builder: (context) {
                      return ConsumerBase<AttendanceRepositories>(
                        onRepository: (rp) {
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
                                rp.attendanceList.isEmpty
                                    ? const NoItem()
                                    : Expanded(
                                        child: GridView.builder(
                                          itemCount: rp.attendanceList.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            crossAxisSpacing: psHeight(1),
                                            mainAxisSpacing: psHeight(1),
                                            mainAxisExtent: psHeight(300),
                                          ),
                                          itemBuilder: (context, index) {
                                            checkInLateMinutes = rp
                                                    .attendanceList[index]
                                                    .checkInLateMinutes ??
                                                0;
                                            checkOutLateMinutes = rp
                                                    .attendanceList[index]
                                                    .checkOutLateMinutes ??
                                                0;
                                            if (rp.attendanceList.isNotEmpty) {
                                              if (rp.attendanceList[index]
                                                          .checkInTime !=
                                                      null &&
                                                  rp
                                                      .attendanceList[index]
                                                      .checkInTime!
                                                      .isNotEmpty) {
                                                DateTime checkintime =
                                                    DateTime.parse(rp
                                                        .attendanceList[index]
                                                        .checkInTime!);
                                                checkInTime = DateFormat.Hms()
                                                    .format(checkintime);
                                              } else {
                                                checkInTime = "";
                                              }

                                              if (rp.attendanceList[index]
                                                          .checkOutTime !=
                                                      null &&
                                                  rp
                                                      .attendanceList[index]
                                                      .checkOutTime!
                                                      .isNotEmpty) {
                                                DateTime checkouttime =
                                                    DateTime.parse(rp
                                                        .attendanceList[index]
                                                        .checkOutTime!);
                                                checkOutTime = DateFormat.Hms()
                                                    .format(checkouttime);
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextCustom(
                                                    text:
                                                        rp.attendanceList[index]
                                                                .subjectName ??
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
                                                        description:
                                                            "Thời gian check-in",
                                                        iconbackground:
                                                            const Color(
                                                                0xFF79AF44),
                                                        data: checkInTime,
                                                      ),
                                                      TodayAttendenceCheckIn(
                                                        title: "Check Out",
                                                        icon: Icons.output,
                                                        description:
                                                            "Thời gian check-out",
                                                        iconbackground:
                                                            AppColor.iconpink,
                                                        data: checkOutTime,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      TodayAttendenceCheckIn(
                                                        title:
                                                            "Checkin Muộn",
                                                        icon: Icons
                                                            .breakfast_dining,
                                                        description:
                                                            "Thời gian check-in muộn",
                                                        iconbackground:
                                                            AppColor.iconpurple,
                                                        data: checkInLateMinutes
                                                            .toString(),
                                                      ),
                                                      TodayAttendenceCheckIn(
                                                        title: "Checkout Muộn",
                                                        icon: Icons
                                                            .calendar_month,
                                                        description:
                                                            "Thời gian check-out muộn",
                                                        iconbackground:
                                                            AppColor.iconbrown,
                                                        data:
                                                            checkOutLateMinutes
                                                                .toString(),
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
                        },
                      );
                    }),
                    // Second Tab: Empty content
                    Builder(builder: (context) {
                      return ConsumerBase<AttendanceRepositories>(
                        onRepository: (rp) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: psHeight(5)),
                                rp.noattendanceList.isEmpty
                                    ? const NoItem()
                                    : Expanded(
                                        child: GridView.builder(
                                          itemCount: rp.noattendanceList.length,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            crossAxisSpacing: psHeight(1),
                                            mainAxisSpacing: psHeight(1),
                                            mainAxisExtent: psHeight(80),
                                          ),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ScanBackGround(
                                                        subjectID: rp
                                                                .noattendanceList[
                                                                    index]
                                                                .id ??
                                                            "",
                                                        beginTime: rp
                                                                .noattendanceList[
                                                                    index]
                                                                .beginTime ??
                                                            "",
                                                        endTime: rp
                                                                .noattendanceList[
                                                                    index]
                                                                .endTime ??
                                                            "",
                                                      ),
                                                    ));
                                              },
                                              child: ClassesItem(
                                                monhoc: rp
                                                        .noattendanceList[index]
                                                        .curriculumName ??
                                                    "",
                                                giaovien: rp
                                                        .noattendanceList[index]
                                                        .tenCBGD ??
                                                    "",
                                                thoigian: rp
                                                        .noattendanceList[index]
                                                        .ngay ??
                                                    "",
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
