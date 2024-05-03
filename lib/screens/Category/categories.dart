import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/Cubit/add_status.dart';
import 'package:e_commerce/Cubit/app_cubit.dart';
import 'package:e_commerce/data/category_data.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/Category/category_grid_item.dart';
import 'package:e_commerce/screens/Filter/main_drawer.dart';
import 'package:e_commerce/screens/Profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dark_mode.dart';
import '../Carts/cart_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isConnected = true;
  AppCubit cubit=AppCubit();
  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
        _isConnected = false;
    }
    else {
        _isConnected = true;
    }
cubit.emit(UpdateData());
  }
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.selected = 0;
    return BlocBuilder<AppCubit, AddStates>(
      builder: (context, state) {
        return !_isConnected? AlertDialog(
            backgroundColor:
            isDarkMode ? Colors.orange : theme.onPrimaryContainer,
            title: const Text(
              "Connection Error!",
              style: TextStyle(color: Colors.white, fontSize: 19),
              textAlign: TextAlign.center,
            ),
            content: const Text(
              "Unable to connect with the server. Check your Internet connection and try again.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                  if(_isConnected){
                    Navigator.pop(context);
                  }
                  },
                  child: const Text(
                    'Try again',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ))
            ]):Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ProfileScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor:
                          isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                      child: Text(
                        FirebaseAuth.instance.currentUser!.displayName
                            .toString()
                            .substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22),
                      ),
                    ),
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 50,
            currentIndex: cubit.selected,
            onTap: (index) {
              cubit.selected = index;
              if (cubit.selected == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const CartScreen()));
                cubit.selected = 0;
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const MyHomePage()));
              }
            },
            items: const [
              BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "Cart", icon: Icon(Icons.shopping_cart)),
            ],
          ),
          drawer: const MainDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.darkMode();
            },
            child:  Icon(isDarkMode?Icons.light_mode:Icons.dark_mode),
          ),
          body: GridView(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              for (final category in categories)
                CategoryGridItem(
                  category: category,
                )
            ],
          ),
        );
      },
    );
  }
}
