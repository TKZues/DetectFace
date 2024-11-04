import 'package:findy/constant/color.dart';
import 'package:findy/src/student/model/diemchuyencan_model.dart';
import 'package:findy/src/student/repositories/chart_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../utils/config/size_config.dart';
import '../../../../../../../widget/text/textcustom.dart';

class Tyletrangthaidiemdanh extends StatefulWidget {
  const Tyletrangthaidiemdanh({super.key});

  @override
  State<Tyletrangthaidiemdanh> createState() => _TyletrangthaidiemdanhState();
}

class _TyletrangthaidiemdanhState extends State<Tyletrangthaidiemdanh> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<ChartRepositories>();
      repo.reportchuyencan(DateFormat("dd-MM-yyyy").format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<ChartRepositories>(),
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
          body: ConsumerBase<ChartRepositories>(
            onRepository: (repository) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: psHeight(10),
                    ),
                    // Dropdown để chọn tuần
                    TextCustom(
                      text: "Hệ thống đang tính tới thời điểm ngày hiện tại",
                      fontSize: psHeight(16),
                      fontWeight: FontWeight.bold,
                      color: AppColor.kRed,
                    ),
                    GridView.builder(
                      itemCount: repository.listDiemchuyencan.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: psHeight(1),
                        mainAxisSpacing: psHeight(1),
                        mainAxisExtent: psHeight(300),
                      ),
                      itemBuilder: (context, index) {
                        String title =
                            repository.listDiemchuyencan[index].className ?? "";
                        int totalCheckIns =
                            repository.listDiemchuyencan[index].totalCheckIns ??
                                0;
                        int totalAbsences =
                            repository.listDiemchuyencan[index].totalAbsences ??
                                0;
                        int totalLate =
                            repository.listDiemchuyencan[index].totalLate ?? 0;

                        List<AttendanceStatus> weeklyData = [
                          AttendanceStatus(
                              'Có mặt', totalCheckIns.toDouble(), Colors.green),
                          AttendanceStatus(
                              'Vắng mặt', totalAbsences.toDouble(), Colors.red),
                          AttendanceStatus(
                              'Đi muộn', totalLate.toDouble(), Colors.orange),
                        ];

                        return SfCircularChart(
                          title: ChartTitle(
                              text: title,
                              textStyle: TextStyle(
                                  fontSize: psHeight(14),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.topTitle)),
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            PieSeries<AttendanceStatus, String>(
                              dataSource: weeklyData,
                              xValueMapper: (AttendanceStatus status, _) =>
                                  status.status,
                              yValueMapper: (AttendanceStatus status, _) =>
                                  status.percentage,
                              dataLabelMapper: (AttendanceStatus status, _) =>
                                  '${status.status}: ${status.percentage}%',
                              pointColorMapper: (AttendanceStatus status, _) =>
                                  status.color,
                              enableTooltip: true,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
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
