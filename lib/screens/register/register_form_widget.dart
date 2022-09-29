import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';

import 'package:my_campus/values/constants.dart';
import 'package:my_campus/screens/login/login_screen.dart';
import 'package:my_campus/screens/home_screen.dart';
import 'package:my_campus/api/auth/authentication.dart';
import 'package:my_campus/providers/auth.dart';

class RegisterFormWidget extends ConsumerStatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends ConsumerState<RegisterFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

  void _toggleLoading() {
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
      // Full name
      final fullName = '${_firstName.text} ${_lastName.text}';

      await auth.signUp(_email.text, _password.text, fullName);
      if (!mounted) return;
      await Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } on AppwriteException catch (e) {
      switch (e.code) {
        case 400:
          _showError("Invalid Email or Password");
          break;
        case 409:
          _showError("User Already Exists");
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
    _firstName.dispose();
    _lastName.dispose();
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
                child: AutoSizeText(
                  "Hi There,",
                  style: Theme.of(context).textTheme.headline3!,
                  maxLines: 1,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: AutoSizeText(
                  "Enter your details to create an account",
                  style: Theme.of(context).textTheme.headline5!,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultSpacing),
          TextFormField(
            controller: _firstName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your first name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultSpacing),
                child: Icon(Icons.person),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || !value.contains(RegExp(r'^[A-Za-z]+$'))) {
                return 'Invalid first name!';
              }
              return null;
            },
          ),
          const SizedBox(height: defaultSpacing),
          TextFormField(
            controller: _lastName,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your last name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultSpacing),
                child: Icon(Icons.person),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty || !value.contains(RegExp(r'^[A-Za-z]+$'))) {
                return 'Invalid last name!';
              }
              return null;
            },
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
                child: Icon(Icons.email),
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
          TextFormField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Confirm password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultSpacing),
                child: Icon(Icons.lock),
              ),
            ),
            validator: (value) {
              if (value != _password.text) {
                return 'Passwords do not match!';
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
                    tag: "sign_up_btn",
                    child: ElevatedButton(
                      onPressed: _onPressedFunction,
                      child: Text(
                        "Sign Up",
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
                "Already have an Account? ",
                style: Theme.of(context).textTheme.bodyText2,
                maxLines: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, LogInScreen.routeName);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AutoSizeText(
                    "Log In",
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
