import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_campus/api/auth/authentication.dart';
import 'package:my_campus/screens/home_screen.dart';
import 'package:my_campus/providers/auth.dart';
import 'package:my_campus/screens/register_screen.dart';
import 'package:my_campus/themes/app_theme.dart';

class LogInScreen extends ConsumerStatefulWidget {
  static const routename = '/LogInScreen';
  const LogInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  /// This function show errors caught by api
  void _showError(String error) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error Occured'),
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
      await Navigator.pushReplacementNamed(context, HomeScreen.routename);
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 1200,
                    height: MediaQuery.of(context).size.height - 30,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(top: 48),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Center(
                                    child: Image.asset(
                                      'my_campus_circle_dark.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 24, right: 24),
                                  child: Text("Welcome Back,",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 24),
                                  child: Text(
                                      "Log in to your account to continue",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400)),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                      // color: Colors.white,
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    controller: _email,
                                    autocorrect: true,
                                    enableSuggestions: true,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Email address',
                                      hintStyle: TextStyle(
                                          color: AppThemes.lightBlueShade),
                                      icon: Icon(Icons.email_outlined,
                                          color: Colors.blue.shade700,
                                          size: 24),
                                      alignLabelWithHint: true,
                                      border: InputBorder.none,
                                    ),
                                    //  Basic Validator
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Invalid email!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    controller: _password,
                                    obscureText: true,
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 8) {
                                        return 'Password is too short!';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: AppThemes.lightBlueShade),
                                      icon: Icon(CupertinoIcons.lock_circle,
                                          color: Colors.blue.shade700,
                                          size: 24),
                                      alignLabelWithHint: true,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(top: 32.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    width: double.infinity,
                                    child: _isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : MaterialButton(
                                            onPressed: _onPressedFunction,
                                            textColor: Colors.blue.shade700,
                                            textTheme: ButtonTextTheme.primary,
                                            minWidth: 100,
                                            padding: const EdgeInsets.all(24),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              side: BorderSide(
                                                  color: Colors.blue.shade700),
                                            ),
                                            child: const Text(
                                              'Log In',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 24.0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Don\'t have an account? ',
                                        style: TextStyle(
                                            color: AppThemes.whiteShade1),
                                        children: [
                                          TextSpan(
                                              text: 'Sign Up Now',
                                              style: TextStyle(
                                                  color: Colors.blue.shade700),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          RegisterScreen
                                                              .routename);
                                                })
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
