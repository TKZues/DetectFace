import 'package:findy/src/findy/repositories/login_repositories.dart';
import 'package:findy/src/findy/screen/login/screens/login.dart';
import 'package:findy/src/findy/screen/login/theme.dart';
import 'package:findy/src/findy/screen/login/widgets/checkbox.dart';
import 'package:findy/src/findy/screen/login/widgets/login_option.dart';
import 'package:findy/src/findy/screen/login/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;

  // Controllers for form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when the widget is destroyed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Padding buildInputForm(String hint, bool isPassword, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? _isObscure : false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: kTextFieldColor),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          suffixIcon: isPassword
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 70),
                    Padding(
                      padding: kDefaultPadding,
                      child: Text(
                        'Create Account',
                        style: titleText,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: kDefaultPadding,
                      child: Row(
                        children: [
                          Text('Already a member?', style: subTitle),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogInScreen()));
                            },
                            child: Text(
                              'Log In',
                              style: textButton.copyWith(
                                decoration: TextDecoration.underline,
                                decorationThickness: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: kDefaultPadding,
                      child: Column(
                        children: [
                          buildInputForm('First Name', false, _firstNameController),
                          buildInputForm('Last Name', false, _lastNameController),
                          buildInputForm('Email', false, _emailController),
                          buildInputForm('Phone', false, _phoneController),
                          buildInputForm('Password', true, _passwordController),
                          buildInputForm('Confirm Password', true, _confirmPasswordController),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: kDefaultPadding,
                      child: CheckBox('Agree to terms and conditions.'),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: kDefaultPadding,
                      child: CheckBox('I have at least 18 years old.'),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: kDefaultPadding,
                      child: PrimaryButton(
                        buttonText: 'Sign Up',
                        onTap: () {
                          // Collect the form data and trigger the signup process
                          rp.signup(
                            _lastNameController.text,
                            
                            _passwordController.text,_emailController.text,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: kDefaultPadding,
                      child: Text(
                        'Or log in with:',
                        style: subTitle.copyWith(color: kBlackColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: kDefaultPadding,
                      child: LoginOption(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
