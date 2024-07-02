// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';
import '../../main.dart';
// import '../../models/Cart.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    getUserCart();
    super.initState();
  }

  List CartIdes = [];

  var total = "";

  var totalPrice = 0;

  var summry_id = "";

  var itemqty = "";
  var itemtotprice = "";

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  Future<List<dynamic>> getUserCart() async {
    var response = await _crud.postRequests(linkgetcart,
        {"CUSTOMERID": sharedPref.getString('CUSTOMERID').toString()});

    return response['data'];
  }

  deleteItem(order_id) async {
    // linkdelete
    var responce = await _crud.postRequests(linkdelete, {
      "order_id": order_id.toString(),
    });

    if (responce['status'] == 'success') {
      setState(() {});
      // totalPrice = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            // Text(
            //   "${demoCarts.length} items",
            //   style: Theme.of(context).textTheme.bodySmall,
            // ),
          ],
        ),
      ),
      body: RefreshIndicator(
        // backgroundColor: Colors.amber,
        color: Color(0xFFFF7643),
        onRefresh: () async {
          setState(() {});

          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: FutureBuilder(
            future: getUserCart(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                  backgroundColor: Colors.amber,
                ));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Empty Cart"),
                );
                // return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final cart_data = snapshot.data!;
                final length = cart_data.length;
                totalPrice = 0;
                CartIdes.clear();

                for (var i = 0; i < cart_data.length; i++) {
                  CartIdes.add(cart_data[i]['ORDEREDNUM']);
                  // add to cart ids list
                  var totprice = cart_data[i]['PROPRICE'];
                  var totqty = cart_data[i]['ORDEREDQTY'];
                  totalPrice +=
                      (int.tryParse(totprice)! * int.tryParse(totqty)!);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key(cart_data[index]['ORDERID'].toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          setState(() {
                            var order_id = cart_data[index]['ORDERID'];
                            deleteItem(order_id);
                          });
                        },
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              SvgPicture.asset("assets/icons/Trash.svg"),
                            ],
                          ),
                        ),
                        child: CartCard(cart: cart_data[index]),
                      ),
                    ),
                  ),
                );
              } else {
                return const Text('No Cart data found');
              }
              // 2451040
            }),
      ),
      bottomNavigationBar:
          CheckoutCard(total_price: totalPrice, cartIdes: CartIdes),
    );
  }
}
