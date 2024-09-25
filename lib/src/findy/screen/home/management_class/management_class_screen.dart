import 'package:findy/src/findy/screen/home/management_class/class_general_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../utils/provider/provider_base.dart';
import '../../../../../widget/text/textcustom.dart';
import '../../../repositories/attendance_repositories.dart';
import '../classes_item.dart';

class ManagementClassScreen extends StatefulWidget {
  const ManagementClassScreen({super.key});

  @override
  State<ManagementClassScreen> createState() => _ManagementClassScreenState();
}

class _ManagementClassScreenState extends State<ManagementClassScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<AttendanceRepositories>();
      repo.getallclassesbyid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
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
            text: "Quản lý lớp học",
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
                  GridView.builder(
                    itemCount: rp.classallList.length,
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
                                  builder: (context) => ClassGeneralScreen(title: rp.classallList[index].mainClassName ?? "",classID: rp.classallList[index].id??"",)));
                        },
                        child: ClassesItem(
                          monhoc: rp.classallList[index].mainClassName ?? "",
                          giaovien: rp.classallList[index].description ?? "",
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
    );
  }
}
