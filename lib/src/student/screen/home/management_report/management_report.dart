import 'package:findy/src/student/model/diemchuyencan_model.dart';
import 'package:findy/src/student/repositories/chart_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/text/textcustom.dart';

class MyTablePage extends StatefulWidget {
  const MyTablePage({super.key});

  @override
  State<MyTablePage> createState() => _MyTablePageState();
}

class _MyTablePageState extends State<MyTablePage> {
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
            title: TextCustom(
              text: "Báo cáo chuyên cần",
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
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
                  // Table Header
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
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text('Tên lớp',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: psWidth(50),
                          alignment: Alignment.center,
                          child: Text('Tổng',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: psWidth(50),
                          alignment: Alignment.center,
                          child: Text('Học',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: psWidth(50),
                          alignment: Alignment.center,
                          child: Text('Nghỉ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: psWidth(50),
                          alignment: Alignment.center,
                          child: Text('Muộn',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: psWidth(50),
                          alignment: Alignment.center,
                          child: Text('Điểm',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  // Table Body
                  Expanded(
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class TableRow1 extends StatelessWidget {
  final DiemchuyencanModel scoreitem;
  final int index;

  const TableRow1({
    super.key,
    required this.index,
    required this.scoreitem,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 11);
    return Container(
      width: double.infinity,
      height: psHeight(50),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.5),
        color: index == 3 || index == 4 ? Colors.yellow[200] : Colors.grey[300],
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 30,
            color: index < 4
                ? Colors.blue
                : index == 4
                    ? Colors.red[700]
                    : index > 16
                        ? Colors.red
                        : Colors.grey[700],
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(scoreitem.className ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: psHeight(10))),
          ),
          Container(
            width: psWidth(50),
            alignment: Alignment.center,
            child: Text(scoreitem.totalSubjects.toString(), style: textStyle),
          ),
          Container(
            width: psWidth(50),
            alignment: Alignment.center,
            child: Text(scoreitem.totalCheckIns.toString(), style: textStyle),
          ),
          Container(
            width: psWidth(50),
            alignment: Alignment.center,
            child: Text(scoreitem.totalAbsences.toString(), style: textStyle),
          ),
          Container(
            width: psWidth(50),
            alignment: Alignment.center,
            child: Text(scoreitem.totalLate.toString(), style: textStyle),
          ),
          Container(
              width: psWidth(50),
              alignment: Alignment.center,
              child: Text(
                  ((scoreitem.totalCheckIns ?? 0) *
                          10 /
                          (scoreitem.totalSubjects ?? 1))
                      .toStringAsFixed(2),
                  style: textStyle)),
        ],
      ),
    );
  }
}
