import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/button/buttoncustom.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class FogotPasswordScreen extends StatefulWidget {
  const FogotPasswordScreen({super.key});

  @override
  State<FogotPasswordScreen> createState() => _FogotPasswordScreenState();
}

class _FogotPasswordScreenState extends State<FogotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
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
          text: "Đăng nhập/ Đăng ký",
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: psWidth(10), vertical: psHeight(6)),
        child: Column(
          children: [
            TextCustom(
              text: "Foget Password",
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: psHeight(18),
              paddingY: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: psWidth(60)),
              child: Text(
                "Enter your email account to reset password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: psHeight(12),
                  fontWeight: FontWeight.w300,
                  color: AppColor.textGrey,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Image.asset(
              "assets/images/fogetpassword.png",
              width: psWidth(350),
              fit: BoxFit.fill,
            ),
            buildInputForm(_emailController, "Enter your email",
                const Icon(Icons.email_outlined)),
                const Spacer(),
            ButtonCustom(
              title: "Get Password",
              colorbtn: AppColor.btncheckin,
              colortitle: AppColor.kGreen,
              onTap: () {},
              paddingX: 120,
              paddingY: 12,
            ),
            SizedBox(
            height: psHeight(20),
          )
          ],
        ),
      ),
    );
  }

  Padding buildInputForm(
      TextEditingController controller, String hintText, Icon icon) {
    // _emailController.text = "kiet3@example.com";
    // _passwordController.text = "123456789";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            fontFamily: 'Inter',
            fontSize: psHeight(12),
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          labelStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: psHeight(12),
              fontWeight: FontWeight.w300),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.black),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.greyBorder),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
            left: 8,
            bottom: 0,
            top: 0,
            right: 15,
          ),
          hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: psHeight(12),
              fontWeight: FontWeight.w300),
          hintText: hintText,
          prefixIcon: icon,
        ),
      ),
    );
  }
}
