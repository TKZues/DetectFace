import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';
import '../../../../../widget/text/textcustom.dart';

class AddTimelineScreen extends StatefulWidget {
  const AddTimelineScreen({super.key});

  @override
  State<AddTimelineScreen> createState() => _AddTimelineScreenState();
}

class _AddTimelineScreenState extends State<AddTimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          body: Column(
            children: [],
          ),
    );
  }
}