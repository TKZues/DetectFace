import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/attendance_repositories.dart';
import 'package:findy/src/student/screen/home/management_subject/classes_item.dart';
import 'package:findy/src/student/screen/scanlive/scan_background.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/provider_base.dart';
import 'package:findy/widget/noitem/noitem.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../widget/timeline.dart';

class ManagementTKB extends StatefulWidget {
  const ManagementTKB({super.key});

  @override
  State<ManagementTKB> createState() => _ManagementTKBState();
}

class _ManagementTKBState extends State<ManagementTKB> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<AttendanceRepositories>();
      repo.getclassesbyid(DateFormat("yyyy-MM-dd").format(DateTime.now()));
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
                Navigator.pushNamedAndRemoveUntil(
                    context, '/bottom', (route) => false);
              },
              type: GFButtonType.transparent,
            ),
            searchBar: true,
            title: TextCustom(
              text: "Quản lý môn học",
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
          body: ConsumerBase<AttendanceRepositories>(
            onRepository: (rp) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TimeLineCustomClass(
                          rp: context.read<AttendanceRepositories>(),
                        ),
                      ),
                      SizedBox(height: psHeight(5)),
                      rp.classList.isEmpty
                          ? const NoItem()
                          : GridView.builder(
                              itemCount: rp.classList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: psHeight(1),
                                mainAxisSpacing: psHeight(1),
                                mainAxisExtent: psHeight(100),
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ScanBackGround(
                                    //         subjectID:
                                    //             rp.classList[index].id ?? "",
                                    //         beginTime:
                                    //             rp.classList[index].beginTime ??
                                    //                 "",
                                    //         endTime:
                                    //             rp.classList[index].endTime ??
                                    //                 "",
                                    //       ),
                                    //     ));
                                  },
                                  child: ClassesItem(
                                    monhoc:
                                        rp.classList[index].curriculumName ??
                                            "",
                                    giaovien: rp.classList[index].tenCBGD ?? "",
                                    thoigian: rp.classList[index].ngay ?? "",
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
