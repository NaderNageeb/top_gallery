import 'package:flutter/material.dart';
import 'package:shop_app/components/crud.dart';

import '../../../constant/linkapi.dart';
import '../../../main.dart';
import '../../cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int count = 0;
  void initState() {
    super.initState();
    getUserCartCount();
  }

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  Future<int> getUserCartCount() async {
    setState(() {});
    var response = await _crud.postRequests(
      linkgetcart,
      {"CUSTOMERID": sharedPref.getString('CUSTOMERID').toString()},
    );
    setState(() {});

    print(response['data'].length);
    return count = response['data'].length;
  }

  // Future<List<dynamic>> Get_user_Cart_count() async {
  //   var response = await _crud.postRequests(linkgetcart,
  //       {"CUSTOMERID": sharedPref.getString('CUSTOMERID').toString()});

  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
          IconBtnWithCounter(
            numOfitem: count,
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          const SizedBox(width: 8),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Bell.svg",
          //   numOfitem: 3,
          //   press: () {},
          // ),
        ],
      ),
    );
  }
}
