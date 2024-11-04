import 'package:findy/src/student/repositories/login_repositories.dart';
import 'package:findy/src/login/screens/reset_password.dart';
import 'package:findy/src/login/screens/signup.dart';
import 'package:findy/src/login/theme.dart';
import 'package:findy/src/login/widgets/login_option.dart';
import 'package:findy/src/login/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Padding buildInputForm(String label, bool pass, TextEditingController controller) {
    _emailController.text = "kiet3@example.com";
    _passwordController.text = "123456789";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: kTextFieldColor),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? const Icon(Icons.visibility_off, color: kTextFieldColor)
                      : const Icon(Icons.visibility, color: kPrimaryColor),
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<LoginRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          body: Consumer<LoginRepositories>(
            builder: (context, rp, child) {
              return Padding(
                padding: kDefaultPadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 120),
                      Text('Welcome Back', style: titleText),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text('New to this app?', style: subTitle),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: textButton.copyWith(
                                decoration: TextDecoration.underline,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      buildInputForm('Email', false, _emailController),
                      buildInputForm('Password', true, _passwordController),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const ResetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: kZambeziColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        onTap: () {
                          rp.login(_passwordController.text, _emailController.text, context);
                        },
                        buttonText: 'Log In',
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Or log in with:',
                        style: subTitle.copyWith(color: kBlackColor),
                      ),
                      const SizedBox(height: 20),
                       const LoginOption(),
                    ],
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
