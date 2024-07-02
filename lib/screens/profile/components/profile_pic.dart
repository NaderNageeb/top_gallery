// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            // backgroundImage: AssetImage("assets/images/Profile Image.png"),
            child: Icon(
              Icons.person,
              size: 80,
              color: Color(0xFFFF7643),
            ),
            backgroundColor: Color.fromARGB(255, 252, 250, 250),
          ),
          // Positioned(
          //   right: -16,
          //   bottom: 0,
          //   child: SizedBox(
          //     height: 46,
          //     width: 46,
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //         foregroundColor: Colors.white, shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50),
          //           side: const BorderSide(color: Colors.white),
          //         ),
          //         backgroundColor: const Color(0xFFF5F6F9),
          //       ),
          //       onPressed: () {},
          //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
