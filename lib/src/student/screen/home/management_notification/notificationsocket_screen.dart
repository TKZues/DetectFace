import 'package:findy/src/student/repositories/notification_repositories.dart';
import 'package:findy/src/student/screen/home/management_notification/notification_item.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/noitem/noitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/text/textcustom.dart';

class NotificationSocketScreen extends StatefulWidget {
  const NotificationSocketScreen({super.key});

  @override
  State<NotificationSocketScreen> createState() =>
      _NotificationSocketScreenState();
}

class _NotificationSocketScreenState extends State<NotificationSocketScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<NotificationRepositories>();
      repo.getNotificationSocket();
     });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<NotificationRepositories>(),
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
          body: ConsumerBase<NotificationRepositories>(
            onRepository: (repository) {
              return Padding(
                padding: EdgeInsets.all(
                  psHeight(10),
                ),
                child: repository.notificationSocketList.isEmpty
                    ? const NoItem()
                    : GridView.builder(
                        itemCount: repository.notificationSocketList.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            mainAxisExtent: psHeight(100)),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: NotificationSocketItem(
                                monhoc: repository.notificationSocketList[index].curriculumName??"", thongbao: repository.notificationSocketList[index].message??"",thoigian: repository.notificationSocketList[index].createdAt,),
                          );
                        },
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
