import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/remote/auth/firebase_helper.dart';
import 'package:e_commerce/screens/Category/categories.dart';
import 'package:e_commerce/screens/Log_Sign/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Cubit/add_status.dart';
import '../../Cubit/app_cubit.dart';
import '../../data/dark_mode.dart';
import '../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  bool isLoginTrue = false;
  bool visible = false;

  final keyForm = GlobalKey<FormState>();
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: keyForm,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 120,
                      child: Lottie.asset(
                        'assets/Shopping.json',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style:  TextStyle(color: isDarkMode ? Colors.white : Colors.black,),
                        validator: (value) {
                          if (value!.isEmpty) return 'Email is Required';
                          return null;
                        },
                        controller: email,
                        decoration:  InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          icon: Icon(
                            Icons.email,
                            color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextFormField(
                        style:  TextStyle(color: isDarkMode ? Colors.white : Colors.black,),
                        validator: (value) {
                          if (value!.isEmpty) return 'Password is Required';
                          return null;
                        },
                        controller: password,
                        obscureText: !visible,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                            icon:  Icon(
                              Icons.lock,
                              color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              icon: Icon(
                                visible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isDarkMode ? Colors.orange : theme.onPrimaryContainer),
                        child: TextButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (keyForm.currentState!.validate()) {
                              signInAction();
                            }
                          },
                        ),
                      ),
                    ),
                    isLoginTrue
                        ? const Text(
                            "Username or Password is incorrect",
                            style: TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "Don't have an account?",
                          style: TextStyle(color: isDarkMode ? Colors.white : theme.onPrimaryContainer),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ));
                            },
                            child:  Text(
                              'SignUp',
                              style: TextStyle(color: isDarkMode ? Colors.orange : theme.onPrimaryContainer),
                            )),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void signInAction() async {
    await FireBaseHelper()
        .SignIn(email.text.toString(), password.text.toString())
        .then((value) => {
              if (value is User)
                {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const MyHomePage()))
                }
              else if (value is String)
                {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.toString(),
                          maxLines: 1,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    backgroundColor: isDarkMode?Colors.orange:theme.onPrimaryContainer,
                  ))
                }
            });
  }
}
