import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/button/buttoncustom.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';

class NoItem extends StatefulWidget {
  const NoItem({super.key});

  @override
  State<NoItem> createState() => _NoItemState();
}

class _NoItemState extends State<NoItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/noitem.jpg"),
        TextCustom(text: "No Item Found", fontWeight: FontWeight.bold, fontSize: psHeight(25),),
        TextCustom(text: "Xin lỗi, hiện tại chưa có thông tin", fontSize: psHeight(15),color: AppColor.textGrey,paddingY: psHeight(10),),
        Align(
          alignment: Alignment.center,
          child: ButtonCustom(
            title: "Go Home",
            colorbtn: AppColor.btncheckin,
            colortitle: AppColor.kGreen,
            onTap: () {},
            paddingX: 100,
            paddingY: 12,
          ),
        ),
      ],
    );
  }
}
