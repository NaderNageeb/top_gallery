// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_interpolation_to_compose_strings, use_build_context_synchronously, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/linkapi.dart';
import '../constants.dart';
import '../main.dart';
import 'crud.dart';
// import '../models/Product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
  }) : super(key: key);

  final double width, aspectRetio;
  final product;
  final VoidCallback onPress;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Crud crud = Crud();
  String _product_id = "";

  likeReation(_product_id) async {
    // print(isLiked);
    var responce = await crud.postRequests(linkaddlikedproduct, {
      "CUSID": sharedPref.getString('CUSTOMERID').toString(),
      "PROID": _product_id.toString(),
    });
    if (responce['status'] == "success") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Added To Favorites !!"),
        ),
      );
    }
    if (responce['status'] == 'Exist') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          padding: EdgeInsets.all(10),
          duration: Duration(seconds: 1),
          content: Text("Already Added  !! "),
        ),
      );
    } else {
      // return responce;
      // print(responce);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: GestureDetector(
        onTap: widget.onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                // child: Image.asset(product.images[0]),
                child: Image.network(
                    "$linkServerImage/${widget.product['IMAGES']}"),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              // "Product Code:" + widget.product['PROID'].toString(),
              widget.product['OWNERNAME'].toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product['PROPRICE']}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () async {
                    _product_id = widget.product['PROID'].toString();
                    await likeReation(_product_id);
                    // print(widget.product['PROPRICE'].toString());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.15),
                      // : kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      colorFilter: ColorFilter.mode(
                          const Color(0xFFFF4848), BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
