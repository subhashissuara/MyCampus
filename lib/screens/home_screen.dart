import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_campus/screens/login/login_screen.dart';
import 'package:my_campus/providers/auth.dart';
import 'package:my_campus/themes/app_theme.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _onPressedFunction() async {
    await ref.read(authProvider).logout();
    Navigator.of(context).pushReplacementNamed(LogInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to MyCampus'),
            const SizedBox(height: 20),
            const Text('This is the home page'),
            const SizedBox(height: 20),
            IconButton(
              onPressed: _onPressedFunction,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
