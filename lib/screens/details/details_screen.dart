// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/crud.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

import '../../constant/linkapi.dart';
// import '../../models/Product.dart';
// import 'components/color_dots.dart';
import '../../constants.dart';
import '../../main.dart';
import 'components/product_description.dart';
// import 'components/product_images.dart';
import 'components/top_rounded_container.dart';

class DetailsScreen extends StatefulWidget {
  final product;
  final product_data;
  static String routeName = "/details";

  const DetailsScreen({super.key, this.product, this.product_data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _product_id = "";
  String _product_price = "";

  Crud crud = Crud();

  AddToCart(_product_id, _product_price) async {
    // print(isLiked);
    var responce = await crud.postRequests(linkaddtocart, {
      "CUSTOMERID": sharedPref.getString('CUSTOMERID').toString(),
      "PROID": _product_id.toString(),
      "PROPRICE": _product_price.toString(),
    });
    if (responce['status'] == "success") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
          content: Text("Added Succussfully !!"),
        ),
      );
    }
    if (responce['status'] == 'Exist') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.all(10),
          duration: Duration(seconds: 1),
          content: Text("Already in Cart!! "),
        ),
      );
    } else {
      // return responce;
      // print(responce);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    final product = agrs.product;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network("$linkServerImage/${product['IMAGES']}"),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      // ColorDots(product: product),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () async {
                _product_id = product['PROID'];
                _product_price = product['PROPRICE'];
                await AddToCart(_product_id, _product_price);
                // Navigator.pushNamed(context, CartScreen.routeName);
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final product;

  ProductDetailsArguments({required this.product});
}
