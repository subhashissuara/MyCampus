import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:my_campus/providers/auth.dart';
import 'package:my_campus/screens/register_screen.dart';
import 'package:my_campus/themes/app_theme.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/loading_screen.dart';

Future main() async {
  await dotenv.load(fileName: "env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Future<void> _init(WidgetRef ref) async {
    final user = await ref.read(authProvider).getAccount();
    if (user != null) {
      ref.read(userLoggedInProvider.state).state = true;
    } else {
      ref.read(userLoggedInProvider.state).state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _init(ref);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCampus',
      themeMode: ThemeMode.dark,
      darkTheme: AppThemes.darkTheme(),
      theme: AppThemes.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: const AuthChecker(),
      routes: {
        LogInScreen.routename: (context) => const LogInScreen(),
        HomeScreen.routename: (context) => const HomeScreen(),
        RegisterScreen.routename: (context) => const RegisterScreen(),
      },
    );
  }
}

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(userLoggedInProvider.state).state;
    if (isLoggedIn == true) {
      return const HomeScreen();
    } else if (isLoggedIn == false) {
      return const LogInScreen();
    }
    return const LoadingScreen();
  }
}
