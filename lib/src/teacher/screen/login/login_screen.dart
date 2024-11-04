import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/login_repositories.dart';
import 'package:findy/src/login/fogotpassword_screen.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:findy/widget/button/buttoncustom.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _yournameController = TextEditingController();
  final TextEditingController _signinemailController = TextEditingController();
  final TextEditingController _signinpasswordController =
      TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<LoginRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: GFAppBar(
            backgroundColor: AppColor.appbarColor,
            centerTitle: true,
            title: TextCustom(
              text: "Đăng nhập/ Đăng ký",
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
          body: ConsumerBase<LoginRepositories>(
            onRepository: (rp) {
              return DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TextCustom(
                      text: "Welcome to TiKay",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: psHeight(18),
                      paddingY: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: psWidth(60)),
                      child: Text(
                        "Sign up or Login below to manage your project, task and productivity",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: psHeight(12),
                          fontWeight: FontWeight.w300,
                          color: AppColor.textGrey,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    const TabBar(tabs: [
                      Tab(
                        text: "Login",
                      ),
                      Tab(
                        text: "Sign up",
                      )
                    ]),
                    Expanded(
                      child: TabBarView(
                        children: [_login(rp), _signup()],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _login(LoginRepositories repo) {
    _emailController.text = "kiet3@example.com";
    _passwordController.text = "123456789";
    return Container(
      color: AppColor.greyBackground,
      child: Column(
        children: [
          SizedBox(
            height: psHeight(30),
          ),
          ButtonCustom(
            title: "Login with Facebook",
            colorbtn: Colors.white,
            colortitle: Colors.black,
            onTap: () {},
          ),
          SizedBox(
            height: psHeight(10),
          ),
          ButtonCustom(
            title: "Login with Facebook",
            colorbtn: Colors.white,
            colortitle: Colors.black,
            onTap: () {},
          ),
          TextCustom(
            text: "or with continue with email",
            fontWeight: FontWeight.w500,
            color: AppColor.textGrey,
            fontSize: psHeight(12),
            paddingY: 15,
          ),
          buildInputForm(false, _emailController, "Enter your email",
              const Icon(Icons.email_outlined)),
          buildInputForm(true, _passwordController, "Enter your password",
              const Icon(Icons.lock)),
          Align(
            alignment: Alignment.bottomLeft,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FogotPasswordScreen(),
                    ));
              },
              child: TextCustom(
                text: "Forgot pasword",
                fontWeight: FontWeight.w500,
                color: AppColor.textGrey,
                fontSize: psHeight(12),
                paddingY: 15,
                paddingX: 10,
              ),
            ),
          ),
          ButtonCustom(
            title: "Login",
            colorbtn: AppColor.btncheckin,
            colortitle: AppColor.kGreen,
            onTap: () {
              repo.login(
                  _passwordController.text, _emailController.text, context);
            },
            paddingX: 140,
            paddingY: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: psHeight(10), horizontal: psWidth(24)),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                  text: "By signin up, you agree to our ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textGrey,
                      fontSize: psHeight(14),
                      fontFamily: 'Inter'),
                ),
                TextSpan(
                  text: "Terms of service",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: AppColor.kGreen,
                      fontSize: psHeight(14),
                      fontFamily: 'Inter'),
                ),
                TextSpan(
                  text: " and ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textGrey,
                      fontSize: psHeight(14),
                      fontFamily: 'Inter'),
                ),
                TextSpan(
                  text: "Privacy policy",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: AppColor.kGreen,
                      fontSize: psHeight(14),
                      fontFamily: 'Inter'),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _signup() {
    return Container(
      color: AppColor.greyBackground,
      child: Column(
        children: [
          SizedBox(
            height: psHeight(20),
          ),
          buildInputForm(false, _yournameController, "Your name",
              const Icon(Icons.account_circle_outlined)),
          buildInputForm(false, _signinemailController, "Enter your email",
              const Icon(Icons.email_outlined)),
          buildInputForm(true, _signinpasswordController, "Enter your password",
              const Icon(Icons.lock_outline_rounded)),
          buildInputForm(true, _confirmpasswordController,
              "Confirm your password", const Icon(Icons.lock_outline_rounded)),
          SizedBox(
            height: psHeight(20),
          ),
          checkPassword(
            _signinpasswordController,
            "At least 8 characters",
            isPasswordValid(_signinpasswordController.text, minLengthPattern),
          ),
          checkPassword(
            _signinpasswordController,
            "At least 1 number",
            isPasswordValid(_signinpasswordController.text, numberPattern),
          ),
          checkPassword(
            _signinpasswordController,
            "Both upper and lower case letters",
            isPasswordValid(
                _signinpasswordController.text, upperLowerCasePattern),
          ),
          const Spacer(),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              TextCustom(
                text:
                    "By agreeing to the terms and conditions, you are entering",
                fontSize: psHeight(12),
                color: AppColor.textDefault,
              )
            ],
          ),
          ButtonCustom(
            title: "Signin",
            colorbtn: AppColor.btncheckin,
            colortitle: AppColor.kGreen,
            onTap: () {},
            paddingX: 140,
            paddingY: 12,
          ),
          SizedBox(
            height: psHeight(20),
          )
        ],
      ),
    );
  }

  Widget checkPassword(
      TextEditingController controller, String text, bool isValid) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: psWidth(10), vertical: psHeight(2)),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_sharp : Icons.cancel,
            color: isValid ? Colors.green : Colors.red,
          ),
          SizedBox(
            width: psWidth(6),
          ),
          TextCustom(
            text: text,
            fontSize: psHeight(12),
            color: AppColor.textDefault,
          )
        ],
      ),
    );
  }

  bool checkPasswordPattern(String password, String pattern) {
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  bool isPasswordValid(String password, String pattern) {
    return checkPasswordPattern(password, pattern);
  }

  String minLengthPattern = r'^.{8,}$';
  String numberPattern = r'(?=.*\d)';
  String upperLowerCasePattern = r'(?=.*[a-z])(?=.*[A-Z])';

  Padding buildInputForm(
      bool pass, TextEditingController controller, String hintText, Icon icon) {
    // _emailController.text = "kiet3@example.com";
    // _passwordController.text = "123456789";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
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
            borderSide: BorderSide.none,
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
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? const Icon(Icons.visibility_off_outlined,
                          color: AppColor.textGrey)
                      : const Icon(Icons.visibility_outlined,
                          color: AppColor.textGrey),
                )
              : null,
        ),
      ),
    );
  }
}
