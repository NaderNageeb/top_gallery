// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/screens/profile/profile_details.dart';

import '../../main.dart';
import '../sign_in/sign_in_screen.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
                // text: sharedPref.getString('username').toString(),
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileDetils()));
                }),
            // ProfileMenu(
            //   text: "Notifications",
            //   icon: "assets/icons/Bell.svg",
            //   press: () {},
            // ),
            // ProfileMenu(
            //   text: "Settings",
            //   icon: "assets/icons/Settings.svg",
            //   press: () {},
            // ),
            // ProfileMenu(
            //   text: "Help Center",
            //   icon: "assets/icons/Question mark.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {
                sharedPref.clear();

                Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInScreen.routeName, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
