import 'package:flutter/material.dart';

import 'package:my_campus/responsive.dart';
import 'package:my_campus/screens/register/register_form_widget.dart';
import 'package:my_campus/values/constants.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: const SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Responsive(
              mobile: MobileLoginScreen(),
              desktop: DesktopLogInWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

class DesktopLogInWidget extends StatelessWidget {
  const DesktopLogInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 10,
                child: Image.asset("assets/my_campus_login_light.png"),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 500,
                child: RegisterFormWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: defaultSpacing),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset("assets/my_campus_login_light.png"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultSpacing),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: RegisterFormWidget(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
