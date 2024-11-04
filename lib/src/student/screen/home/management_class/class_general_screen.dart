import 'package:findy/src/student/repositories/postclass_repositories.dart';
import 'package:findy/src/student/screen/home/attendance_history/today_attendence.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/noitem/noitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/text/textcustom.dart';

class ClassGeneralScreen extends StatefulWidget {
  final String title;
  final String classID;

  const ClassGeneralScreen({
    Key? key,
    required this.title,
    required this.classID,
  }) : super(key: key);

  @override
  State<ClassGeneralScreen> createState() => _ClassGeneralScreenState();
}

class _ClassGeneralScreenState extends State<ClassGeneralScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<PostClassRepositories>();
      repo.getpost(widget.classID);
      repo.getinoutinclass(widget.classID);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<PostClassRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          appBar: _buildAppBar(),
          body: ConsumerBase<PostClassRepositories>(
            onRepository: (rp) {
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildTabBar(),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [postScreen(rp), fileScreen(), _buildHistory(rp)],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildChatBar(rp), // Chat bar at the bottom
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  GFAppBar _buildAppBar() {
    return GFAppBar(
      backgroundColor: AppColor.appbarColor,
      centerTitle: true,
      leading: GFIconButton(
        icon: Container(
          padding: EdgeInsets.symmetric(
            horizontal: psWidth(3),
            vertical: psHeight(4),
          ),
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
        text: widget.title,
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
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelColor: AppColor.textDefault,
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: psHeight(10),
        fontWeight: FontWeight.bold,
      ),
      controller: _tabController,
      tabs: const [
        Tab(text: "CHUNG"),
        Tab(text: "TỆP"),
        Tab(text: "LỊCH SỬ"),
      ],
    );
  }

  Widget postScreen(PostClassRepositories repo) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: psWidth(10),
        vertical: psHeight(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            repo.postclassList.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: repo.postclassList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: psHeight(10)),
                        child: _buildPostItem(repo, index),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/images/empty-box.svg",
                          width: psWidth(400),
                          fit: BoxFit.cover,
                        ),
                        TextCustom(
                          text: "Không có dữ liệu",
                          fontSize: psHeight(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget fileScreen() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: psWidth(10),
        vertical: psHeight(10),
      ),
      child: SingleChildScrollView(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: psWidth(5),
            mainAxisSpacing: psHeight(10),
            mainAxisExtent: psHeight(100),
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return _buildfileScreen();
          },
        ),
      ),
    );
  }

  Widget _buildPostItem(PostClassRepositories repo, int index) {
    return Container(
      padding: EdgeInsets.all(psWidth(8)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(psHeight(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                repo.postclassList[index].image ?? "",
                width: psWidth(50),
                height: psHeight(50),
              ),
              SizedBox(width: psWidth(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: repo.postclassList[index].username ?? "",
                    fontSize: psHeight(14),
                  ),
                  SizedBox(height: psHeight(5)),
                  TextCustom(
                    text: repo.postclassList[index].date ?? "",
                    fontSize: psHeight(12),
                  ),
                ],
              ),
            ],
          ),
          Text(
            repo.postclassList[index].description ?? "",
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: psHeight(13),
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: psHeight(8)),
            child: Row(
              children: [
                SvgPicture.asset("assets/icon/add-reaction-svgrepo-com.svg"),
                SizedBox(width: psWidth(6)),
                const Icon(Icons.ios_share_outlined, color: Colors.grey),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: psHeight(8)),
            child: Row(
              children: [
                const Icon(Icons.reply),
                SizedBox(width: psWidth(6)),
                const TextCustom(text: "Trả lời"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildfileScreen() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: psWidth(10),
        vertical: psHeight(10),
      ),
      child: Container(
        padding: EdgeInsets.all(psWidth(8)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(psHeight(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "folder-svgrepo-com.svg",
              width: psWidth(50),
              height: psHeight(50),
            ),
            SizedBox(width: psWidth(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  text: "Class Material",
                  fontSize: psHeight(13),
                ),
                SizedBox(height: psHeight(5)),
                TextCustom(
                  text: "Người sửa đổi: Nguyễn Thị Minh Hương",
                  fontSize: psHeight(12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(PostClassRepositories rp) {
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
                      mainAxisExtent: psHeight(300),
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

  Widget _buildChatBar(PostClassRepositories repositories) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.symmetric(horizontal: psWidth(10), vertical: psHeight(5)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _chatController,
              decoration: InputDecoration(
                  fillColor: AppColor.greyBackground,
                  hintText: 'Nhập tin nhắn...',
                  hintStyle: TextStyle(
                      color: AppColor.textGrey,
                      fontFamily: "Inter",
                      fontSize: psHeight(15)),
                  suffixIcon: const Icon(Icons.image),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(psHeight(30)),
                      borderSide: BorderSide.none),
                  prefixIcon: Icon(Icons.face_retouching_natural_rounded,
                      size: psHeight(18))),
            ),
          ),
          SizedBox(
            width: psWidth(10),
          ),
          Container(
            padding: EdgeInsets.all(psHeight(1)),
            decoration:
                BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.paperPlane,
                color: AppColor.white,
                size: psHeight(14),
              ),
              onPressed: () {
                repositories.sendpost(widget.classID, _chatController.text,
                    "https://www.shutterstock.com/image-vector/portrait-beautiful-latin-american-woman-600nw-2071168457.jpg");
                _chatController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
