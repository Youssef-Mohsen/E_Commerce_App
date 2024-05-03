import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../data/dark_mode.dart';
import '../../main.dart';
import '../../remote/auth/firebase_helper.dart';
import '../Category/categories.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNum = TextEditingController();
  final address = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: username,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username is required";
                        }
                        if (username.text.substring(0, 1) == " ") {
                          return "No Space Please";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: isDarkMode
                              ? Colors.orange
                              : theme.onPrimaryContainer,
                        ),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: IntlPhoneField(
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      controller: phoneNum,
                      validator: (value) {
                        if (value?.completeNumber == null) {
                          return 'Phone Must Not Be Empty';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Phone Number",
                      ),
                      languageCode: 'en',
                      dropdownTextStyle: TextStyle(
                          color: isDarkMode
                              ? Colors.white
                              : theme.onPrimaryContainer),
                      dropdownIcon: Icon(
                        Icons.arrow_drop_down,
                        color: isDarkMode
                            ? Colors.orange
                            : theme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) return 'Address is Required';
                        return null;
                      },
                      controller: address,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address',
                        icon: Icon(
                          Icons.location_on,
                          color: isDarkMode
                              ? Colors.orange
                              : theme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) return 'Email is Required';
                        return null;
                      },
                      controller: email,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email,
                          color: isDarkMode
                              ? Colors.orange
                              : theme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: !visible,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: isDarkMode
                                ? Colors.orange
                                : theme.onPrimaryContainer,
                          ),
                          border: InputBorder.none,
                          hintText: "Password",
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
                                color: isDarkMode
                                    ? Colors.orange
                                    : theme.onPrimaryContainer,
                              ))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        } else if (password.text != confirmPassword.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                      obscureText: !visible,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: isDarkMode
                                ? Colors.orange
                                : theme.onPrimaryContainer,
                          ),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
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
                                color: isDarkMode
                                    ? Colors.orange
                                    : theme.onPrimaryContainer,
                              ))),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isDarkMode
                            ? Colors.orange
                            : theme.onPrimaryContainer),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signOutAction();
                          }
                        },
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: isDarkMode
                                    ? Colors.orange
                                    : theme.onPrimaryContainer),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signOutAction() async {
    await FireBaseHelper()
        .SignUp(
            username.text.toString(),
            password.text.toString(),
            email.text.toString(),
            phoneNum.text.toString(),
            address.text.toString())
        .then((value) => {
              if (value is User)
                {
                  username.clear(),
                  password.clear(),
                  confirmPassword.clear(),
                  email.clear(),
                  phoneNum.clear(),
                  address.clear(),
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
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    backgroundColor:
                        isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                  ))
                }
            });
  }
}
