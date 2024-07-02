// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_final_fields, prefer_typing_uninitialized_variables, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';

import '../../../components/alerts.dart';
import '../../../components/crud.dart';
import '../../../constant/linkapi.dart';
import '../../init_screen.dart';
import '../../sign_in/sign_in_screen.dart';
import '../cart_screen.dart';

class CheckoutCard extends StatefulWidget {
  final total_price;
  final cartIdes;
  const CheckoutCard({
    Key? key,
    required this.total_price,
    required this.cartIdes,
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  Crud _crud = Crud();

  checkout() async {
    // i used this code to remove [] from the list
    // String myListString = widget.cartIdes.join(',');
    // print(widget.cartIdes.join(','));
    if (widget.total_price != 0) {
      // print("Done");

      var responce = await _crud.postRequests(linkcheckout, {
        "orderIds": widget.cartIdes.join(',').toString(),
        "totalPrice": widget.total_price.toString(),
      });

      if (responce['status'] == 'success') {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertSuccess(
              message: "Order Confirm",
              routename: InitScreen.routeName,
            );
          },
        );
      }

      if (responce['status'] == 'qtyno') {}

      if (responce['status'] == 'Faild') {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertFailed(
              message: "Order Faild ",
              // routename: "login",
            );
          },
        );
      }
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertFailed(
            message: "Order Price Is 0",
            // routename: "login",
          );
        },
      );
      // Navigator.popAndPushNamed(context, CartScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            if (widget.total_price != 0)
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "Total:\n",
                        children: [
                          TextSpan(
                            // text: "\$337.15",
                            text: "\$ ${widget.total_price}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // print(cartIdes);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Payment"),
                                  Divider(
                                    color: Colors.black,
                                    height: 5,
                                  )
                                ],
                              ),
                              content: SizedBox(
                                height: 100,
                                child: Text(
                                    "Your Order Total Price is \$${widget.total_price} Do You Want Confirm Order ?"),
                              ),
                              actions: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(),
                                    onPressed: () async {
                                      // cartIdes
                                      // total_price
                                      await checkout();
                                    },
                                    child: const Text(
                                      "Confirm",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Color.fromARGB(255, 222, 13, 13),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Check Out"),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
