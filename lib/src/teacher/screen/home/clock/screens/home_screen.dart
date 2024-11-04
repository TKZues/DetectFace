import 'package:getwidget/getwidget.dart';

import '../../../../../../constant/color.dart';
import '../../../../../../utils/config/size_config.dart';
import '../../../../../../widget/text/textcustom.dart';
import 'components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // we have to call this on our starting page
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Body(),
    );
  }

  GFAppBar buildAppBar(BuildContext context) {
    return GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        title: TextCustom(
          text: "Trang chủ",
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

  Padding buildAddButton(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: getProportionateScreenWidth(32),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
