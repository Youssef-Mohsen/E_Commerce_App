/*
FirebaseAuth.instance.currentUser!.displayName.toString()*/
import 'package:e_commerce/remote/auth/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/dark_mode.dart';
import '../../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'UserName: ',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: 2.0,
            ),
          ), //NAME
          const SizedBox(
            height: 10.0,
          ), //SMALL SPACE
          Text(
            FirebaseAuth.instance.currentUser!.displayName.toString(),
            style: TextStyle(
                color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                letterSpacing: 2.0,
                fontSize: 18.0),
          ), //YOUSSEF MOHSEN
          const SizedBox(
            height: 30.0,
          ), //BIG SPACE
          /*Text(
            'Password: ',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: 2.0,
            ),
          ), //LEVEL
          const SizedBox(
            height: 10.0,
          ), //SMALL SPACE
          Text(
            FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
            style: TextStyle(
              color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
              letterSpacing: 2.0,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ), //BIG SPACE
          Text(
            'Address: ',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
              letterSpacing: 2.0,
            ),
          ), //ID
          const SizedBox(
            height: 10.0,
          ), //SMALL SPACE
          Text(
            FirebaseAuth.instance.currentUser!.photoURL.toString(),
            style: TextStyle(
              color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
              letterSpacing: 2.0,
              fontSize: 18.0,
            ),
          ),*/
         /* const SizedBox(
            height: 30.0,
          ), // BIG SPACE*/
          Row(
            children: [
              Icon(
                Icons.mail,
                color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: TextStyle(
                  color: isDarkMode ? Colors.orange : theme.onPrimaryContainer,
                  letterSpacing: 2.0,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FireBaseHelper().SignOut(context);
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
