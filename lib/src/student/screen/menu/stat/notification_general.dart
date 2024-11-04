import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/notification_repositories.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class NotificationGeneral extends StatefulWidget {
  const NotificationGeneral({super.key});

  @override
  State<NotificationGeneral> createState() => _NotificationGeneralState();
}

class _NotificationGeneralState extends State<NotificationGeneral> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final repo = context.read<NotificationRepositories>();
      repo.getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<NotificationRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.aicamMenuBase,
            iconTheme: const IconThemeData(
              color: AppColor.whiteBox,
            ),
            title: Text("Thông báo",
                style:
                    TextStyle(fontSize: psWidth(18), color: AppColor.whiteBox)),
          ),
          body: ConsumerBase<NotificationRepositories>(
            onRepository: (rp) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(psHeight(6)),
                  child: rp.notificationList.isEmpty
                      ? Align(
                        alignment: Alignment.center,
                        child: Column(
                            children: [
                              Icon(
                                Icons.message,
                                size: psHeight(60),
                              ),
                              SizedBox(
                                height: psHeight(10),
                              ),
                              TextCustom(
                                text: "Không có thông báo",
                                fontWeight: FontWeight.bold,
                                fontSize: psHeight(14),
                              ),
                              const Text(
                                "Chúng tôi sẽ thông báo đến bạn khi nhận được \n một số cập nhật mới",
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                      )
                      : GridView.builder(
                          itemCount: rp.notificationList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: psHeight(1),
                            mainAxisSpacing: psHeight(1),
                            mainAxisExtent: psHeight(110),
                          ),
                          itemBuilder: (context, index) {
                            String messageSubject =
                                rp.notificationList[index].messageSubject ?? "";
                            String senderName =
                                rp.notificationList[index].senderName ?? "";
                            String creationDate =
                                rp.notificationList[index].creationDate ?? "";

                            return InkWell(
                              onTap: () {},
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Padding(
                                  padding: EdgeInsets.all(psHeight(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: Icon(
                                          Icons.notifications_active,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextCustom(
                                              text: senderName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: psHeight(14),
                                            ),
                                            const SizedBox(height: 4),
                                            TextCustom(
                                              text: messageSubject,
                                              fontSize: psHeight(12),
                                              color: const Color.fromARGB(255, 103, 103, 103),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: TextCustom(
                                          text: creationDate,
                                          fontSize: psHeight(10),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
