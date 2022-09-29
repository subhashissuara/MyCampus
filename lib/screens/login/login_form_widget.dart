import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:my_campus/values/constants.dart';
import 'package:my_campus/screens/register/register_screen.dart';
import 'package:my_campus/screens/home_screen.dart';
import 'package:my_campus/api/auth/authentication.dart';
import 'package:my_campus/providers/auth.dart';

class LogInFormWidget extends ConsumerStatefulWidget {
  const LogInFormWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LogInFormWidgetState();
}

class _LogInFormWidgetState extends ConsumerState<LogInFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

  void _toggleLoading() {
    if (!mounted) return;
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  // Shows errors in a dialog box
  void _showError(String error) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error Occurred'),
        content: Text(error),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ],
      ),
    );
  }

  late final Authentication auth = ref.watch(authProvider);

  Future<void> _onPressedFunction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _toggleLoading();

    try {
      await auth.login(_email.text, _password.text);
      if (!mounted) return;
      await Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on AppwriteException catch (e) {
      switch (e.code) {
        case 400:
          _showError("Invalid Email or Password");
          break;
        case 401:
          _showError("Invalid Credentials");
          break;
        case 500:
          _showError("Internal Server Error");
          break;
        case 503:
          _showError("Service Unavailable");
          break;
        case 504:
          _showError("Gateway Timeout");
          break;
        default:
          _showError(e.message!);
      }
    } finally {
      _toggleLoading();
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: AutoSizeText("Welcome Back,",
                    style: Theme.of(context).textTheme.headline3!, maxLines: 1),
              ),
              Container(
                margin: const EdgeInsets.only(left: 7),
                child: AutoSizeText(
                  "Log in to your account to continue",
                  style: Theme.of(context).textTheme.headline5!,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultSpacing),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultSpacing),
                child: Icon(Icons.person),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Invalid email!';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultSpacing),
          TextFormField(
            controller: _password,
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultSpacing),
                child: Icon(Icons.lock),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || value.length < 8) {
                return 'Password is too short!';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultSpacing),
          Container(
            alignment: Alignment.center,
            child: _isLoading
                ? Container(
                    margin: const EdgeInsets.all(defaultSpacing),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator())
                : Hero(
                    tag: "login_btn",
                    child: ElevatedButton(
                      onPressed: _onPressedFunction,
                      child: Text(
                        "Log In",
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.merge(const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: defaultSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AutoSizeText(
                "Don’t have an Account? ",
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routeName);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AutoSizeText(
                    "Sign Up",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.merge(const TextStyle(fontWeight: FontWeight.bold)),
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: defaultSpacing),
        ],
      ),
    );
  }
}
