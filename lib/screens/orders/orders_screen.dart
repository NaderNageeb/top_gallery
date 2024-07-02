// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import '../../components/crud.dart';

import '../../constant/linkapi.dart';
import '../../constants.dart';
import '../../main.dart';
import 'order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();

    GetMyOrders();
  }

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  Future<List<dynamic>> GetMyOrders() async {
    var response = await _crud.postRequests(linkgetmyorders,
        {"user_id": sharedPref.getString('CUSTOMERID').toString()});

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Orders",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          // backgroundColor: Colors.amber,
          color: Color(0xFFFF7643),
          onRefresh: () async {
            setState(() {});

            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: FutureBuilder(
              future: GetMyOrders(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.amber,
                    backgroundColor: Colors.amber,
                  ));
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("No Orders"),
                  );
                  // return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final order_data = snapshot.data!;
                  final length = order_data.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      itemCount: length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),

                        // child: CartCard(cart: order_data[index]),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OrderDetails(
                                      OrderNum: order_data[index]['ORDEREDNUM'],
                                    )));
                          },
                          child: Row(
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
                                    child: Icon(
                                      Icons.shopping_cart,
                                      size: 40,
                                      color: kPrimaryColor,
                                    ),
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

                                      // Quantity display
                                      Text(
                                        // widget.cart['ORDEREDQTY'].toString(),
                                        "Order #" +
                                            order_data[index]['SUMMARYID'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    order_data[index]['ORDEREDSTATS'],
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 8),
                                  // Text.rich(
                                  //   TextSpan(
                                  //     // text: "\$${widget.cart['PROPRICE']}",
                                  //     text: "test",
                                  //     style: const TextStyle(
                                  //         fontWeight: FontWeight.w600,
                                  //         color: kPrimaryColor),
                                  //     children: [
                                  //       TextSpan(
                                  //           // text: " x${widget.cart['ORDEREDQTY']}",
                                  //           text: "test",

                                  //           // text: "2",
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .bodyLarge),
                                  //     ],
                                  //   ),
                                  // ),
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
                                            "\$${order_data[index]['PAYMENT']}",

                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
      ),
      // bottomNavigationBar:
      //     CheckoutCard(total_price: totalPrice, cartIdes: CartIdes),
    );
  }
}
