import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/repositories/attendance_repositories.dart';
import 'package:findy/src/findy/screen/home/classes_item.dart';
import 'package:findy/src/findy/screen/scanlive/scan_background.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/provider_base.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClassesManageScreen extends StatefulWidget {
  const ClassesManageScreen({super.key});

  @override
  State<ClassesManageScreen> createState() => _ClassesManageScreenState();
}

class _ClassesManageScreenState extends State<ClassesManageScreen> {
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
                Navigator.pop(context);
              },
              type: GFButtonType.transparent,
            ),
            searchBar: true,
            title: TextCustom(
              text: "Quản lý môn học",
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
          body: ConsumerBase<AttendanceRepositories>(
            onRepository: (rp) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: psHeight(5)),
                    Text(
                      "Lớp học hôm nay",
                      style: TextStyle(
                          fontSize: psHeight(15),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    GridView.builder(
                      itemCount: rp.classList.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: psHeight(1),
                        mainAxisSpacing: psHeight(1),
                        mainAxisExtent: psHeight(100),
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScanBackGround(
                                    // classID: rp.classList[index].id ?? "",
                                  ),
                                ));
                          },
                          child: ClassesItem(
                            monhoc: rp.classList[index].curriculumName ?? "",
                            giaovien: rp.classList[index].tenCBGD ?? "",
                            thoigian: rp.classList[index].ngay ?? "",
                          ),
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
