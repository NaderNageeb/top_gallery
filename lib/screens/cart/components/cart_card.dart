// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../components/crud.dart';
import '../../../constant/linkapi.dart';
import '../../../constants.dart';
import '../cart_screen.dart';
// import '../../../models/Cart.dart';

class CartCard extends StatefulWidget {
  final cart;
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

Crud _crud = Crud();

class _CartCardState extends State<CartCard> {
  plusQty(cartId, cartQty, itemQty, product_price) async {
    var responce = await _crud.postRequests(linkplus, {
      "order_id": cartId.toString(),
      "cartQty": cartQty.toString(),
      "itemQty": itemQty.toString(),
      "product_price": product_price.toString()
    });

    if (responce['status'] == 'Qtynon') {
      // setState(() {});
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Sorry No Avaliable Quantity !!"),
        ),
      );
    }
    if (responce['status'] == 'success') {
      setState(() {});

      // Navigator.pushNamed(context, CartScreen.routeName);
      Navigator.popAndPushNamed(context, CartScreen.routeName);
      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("cart qty Updated"),
      //   ),
      // );
    }
    if (responce['status'] == 'Faild') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Error !!"),
        ),
      );
    }
  }

  minusQty(cartId, cartQty, itemQty, product_price) async {
    // print(cartId.toString());
    // print(product_price.toString());
    var responce = await _crud.postRequests(linkminis, {
      "order_id": cartId.toString(),
      "product_price": product_price.toString(),
    });

    if (responce['status'] == 'Qtynon') {
      // setState(() {});
      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("Sorry No Avaliable Quantity !!"),
      //   ),
      // );
    }
    if (responce['status'] == 'success') {
      setState(() {});

      Navigator.popAndPushNamed(context, CartScreen.routeName);

      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text("cart qty Updated"),
      //   ),
      // );
    }
    if (responce['status'] == 'Faild') {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Error !!"),
        ),
      );
    }
  }

  Calculate(item_price, qty) {
    int? x = int.tryParse(qty);
    int? y = int.tryParse(item_price);

    var z = x! * y!;

    return "$z";
    // return Text("Total : " + "$z");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              // child: Image.asset(cart.product.images[0]),
              child: Image.network("$linkServerImage/${widget.cart['IMAGES']}"),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Minus button
                InkWell(
                  onTap: () async {
                    var product_price = widget.cart['PROPRICE'];
                    var cartId = widget.cart['ORDERID'];
                    int cartQty = int.parse(widget.cart['ORDEREDQTY']);
                    int itemQty = int.parse(widget.cart['PROQTY']);
                    await minusQty(cartId, cartQty, itemQty, product_price);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Quantity display
                Text(
                  widget.cart['ORDEREDQTY'].toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                // Plus button
                InkWell(
                  onTap: () async {
                    var product_price = widget.cart['ORDEREDPRICE'];
                    var cartId = widget.cart['ORDERID'];
                    int cartQty = int.parse(widget.cart['ORDEREDQTY']);
                    int itemQty = int.parse(widget.cart['PROQTY']);
                    await plusQty(cartId, cartQty, itemQty, product_price);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            // Text(
            //   cart['PROID'].toString(),
            //   style: const TextStyle(color: Colors.black, fontSize: 16),
            //   maxLines: 2,
            // ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$${widget.cart['PROPRICE']}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
                children: [
                  TextSpan(
                      text: " x${widget.cart['ORDEREDQTY']}",
                      // text: "2",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
        // /////////////////////
        // const SizedBox(width: 50),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Minus button

                // Quantity display
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(2),
              child: Text.rich(
                TextSpan(
                  // text: "\$${cart['PROPRICE']}",
                  text:
                      "\$${Calculate(widget.cart['PROPRICE'], widget.cart['ORDEREDQTY'])}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
