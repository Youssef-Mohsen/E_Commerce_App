import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:e_commerce/screens/Category/categories.dart';
import 'package:e_commerce/screens/Log_Sign/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/dark_mode.dart';
import 'firebase_options.dart';

var theme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var darkTheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 131, 57, 0),
);

var theme2 = ThemeData(useMaterial3: true).copyWith(
  colorScheme: theme,
  appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: theme.onPrimaryContainer.withOpacity(0.97),
      foregroundColor: theme.primaryContainer),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: theme.onPrimaryContainer,
          foregroundColor: Colors.white)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData().copyWith(
      backgroundColor: theme.onPrimaryContainer, foregroundColor: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      backgroundColor: theme.onPrimaryContainer,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey[600]),
);

var darkTheme2 = ThemeData.dark(useMaterial3: true).copyWith(
  colorScheme: darkTheme,
  appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: darkTheme.background, foregroundColor: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
    backgroundColor: Colors.orange,
    selectedItemColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange, foregroundColor: Colors.white)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData()
      .copyWith(backgroundColor: Colors.orange, foregroundColor: Colors.white),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getData(),
      child: BlocBuilder<AppCubit, AddStates>(
        builder: (context,dynamic) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: theme2,
            darkTheme: darkTheme2,
            home: start(),
          );
        },
      ),
    );
  }

  Widget start() {
    if (FirebaseAuth.instance.currentUser != null) {
      return const MyHomePage();
    } else {
      return const LoginPage();
    }
  }
}