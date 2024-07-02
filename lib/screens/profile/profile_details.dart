// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/screens/profile/profile_form.dart';

import '../../constants.dart';
import '../sign_up/components/sign_up_form.dart';

class ProfileDetils extends StatefulWidget {
  const ProfileDetils({super.key});

  @override
  State<ProfileDetils> createState() => _ProfileDetilsState();
}

class _ProfileDetilsState extends State<ProfileDetils> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // const Text("Register Account", style: headingStyle),
                  // const Text(
                  //   "Complete your details or continue \nwith social media",
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 16),
                  const ProfileDetailsForm(),
                  const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SocalCard(
                  //       icon: "assets/icons/google-icon.svg",
                  //       press: () {},
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/facebook-2.svg",
                  //       press: () {},
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/twitter.svg",
                  //       press: () {},
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 16),
                  // Text(
                  //   'By continuing your confirm that you agree \nwith our Term and Condition',
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
