import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/repositories/attendance_repositories.dart';
import 'package:findy/src/findy/screen/home/attendance_history/today_attendence.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/provider_base.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:findy/widget/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<AttendanceRepositories>();
      // repo.getNotification();
      repo.getinout(DateFormat('dd-MM-yyyy').format(DateTime.now()));
    });
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
            padding: EdgeInsets.symmetric(horizontal: psWidth(3), vertical: psHeight(4)),
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
        searchBar: true,
        title: TextCustom(text: "Quản lý nhận diện", color: Colors.white,fontSize: psHeight(16),),
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
          body: Builder(builder: (context) {
            return ConsumerBase<AttendanceRepositories>(
              onRepository: (rp) {
                String checkOuttime;
                String checkInTime;
                String totalday;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeLineCustom(
                        rp: rp,
                      ),
                      SizedBox(height: psHeight(5)),
                      Text(
                        "Today Attendence",
                        style: TextStyle(
                            fontSize: psHeight(15),
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: rp.classList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: psHeight(1),
                            mainAxisSpacing: psHeight(1),
                            mainAxisExtent: psHeight(330),
                          ),
                          itemBuilder: (context, index) {
                            if (rp.attendanceList.isNotEmpty) {
                              if (rp.attendanceList[index].checkInTime !=
                                      null &&
                                  rp.attendanceList[index].checkInTime!
                                      .isNotEmpty) {
                                DateTime checkintime = DateTime.parse(
                                    rp.attendanceList[index].checkInTime!);
                                checkInTime =
                                    DateFormat.Hms().format(checkintime);
                              } else {
                                checkInTime =
                                    ""; // Không có giá trị checkInTime
                              }

                              // Kiểm tra nếu có giá trị checkOutTime và không phải là chuỗi rỗng
                              if (rp.attendanceList[index].checkOutTime !=
                                      null &&
                                  rp.attendanceList[index].checkOutTime!
                                      .isNotEmpty) {
                                DateTime checkouttime = DateTime.parse(
                                    rp.attendanceList[index].checkOutTime!);
                                checkOuttime =
                                    DateFormat.Hms().format(checkouttime);
                              } else {
                                checkOuttime =
                                    ""; // Không có giá trị checkOutTime
                              }
                              totalday = rp.attendanceList.length.toString();
                            } else {
                              checkInTime = "";
                              checkOuttime = "";
                              totalday = "";
                            }
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => ScanBackGround(
                                //         classID: rp.classList[index].id ?? "",
                                //       ),
                                //     ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                    text: rp.classList[index].curriculumName ??
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
                                          description: "On Time",
                                          iconbackground:
                                              const Color(0xFF79AF44),
                                          data: checkInTime),
                                      TodayAttendenceCheckIn(
                                          title: "Check Out",
                                          icon: Icons.output,
                                          description: "Go Home",
                                          iconbackground: AppColor.iconpink,
                                          data: checkOuttime),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const TodayAttendenceCheckIn(
                                          title: "Break Time",
                                          icon: Icons.breakfast_dining,
                                          description: "Avg Time 30 min",
                                          iconbackground: AppColor.iconpurple,
                                          data: "00:30 min"),
                                      TodayAttendenceCheckIn(
                                          title: "Total Days",
                                          icon: Icons.calendar_month,
                                          description: "Working Days",
                                          iconbackground: AppColor.iconbrown,
                                          data: totalday),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(psHeight(6)),
                      //   child: Text("Your Activity",
                      //       style: TextStyle(
                      //           fontSize: psHeight(15),
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold)),
                      // )
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
