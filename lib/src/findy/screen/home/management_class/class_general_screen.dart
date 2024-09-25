// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:findy/src/findy/repositories/postclass_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/text/textcustom.dart';

class ClassGeneralScreen extends StatefulWidget {
  final String title;
  final String classID;
  // ignore: use_super_parameters
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<PostClassRepositories>();
      repo.getpost(widget.classID);
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
      value: context.read<PostClassRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          appBar: _buildAppBar(),
          body: ConsumerBase<PostClassRepositories>(
            onRepository: (rp) {
              return Column(
                children: [
                  _buildTabBar(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [postScreen(rp), fileScreen()],
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
        color: Colors.white,
        fontSize: psHeight(12),
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
                    physics:
                        const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
                    shrinkWrap: true,
                    itemCount: repo.postclassList.length, // Set the number of items
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.symmetric(vertical: psHeight(10)),
                          child: _buildPostItem(repo, index));
                    },
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          "assets/images/empty-box.svg",
                          width: psWidth(psWidth(400)),
                          fit: BoxFit.cover,
                        ),
                        TextCustom(
                          text: "Không có dữ liệu",
                          fontSize: psHeight(14),
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                  )
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
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: psWidth(5),
                mainAxisSpacing: psHeight(10),
                mainAxisExtent: psHeight(100),
              ),
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
              shrinkWrap: true,
              itemCount: 2, // Set the number of items
              itemBuilder: (context, index) {
                return _buildfileScreen();
              },
            ),
          ],
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
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
            repo.postclassList[index].description ?? "",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: psHeight(13),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: psHeight(8)),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: AppColor.greyBorder),
                    left: BorderSide.none,
                    right: BorderSide.none)),
            child: Row(
              children: [
                SvgPicture.asset("assets/icon/add-reaction-svgrepo-com.svg"),
                SizedBox(
                  width: psWidth(6),
                ),
                Icon(
                  Icons.ios_share_outlined,
                  color: Colors.grey,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: psHeight(8)),
            child: Row(
              children: [
                Icon(Icons.reply),
                SizedBox(
                  width: psWidth(6),
                ),
                TextCustom(text: "Trả lời")
              ],
            ),
          )
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
        child: Column(
          children: [
            Row(
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
          ],
        ),
      ),
    );
  }
}
