// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';
import '../../constants.dart';
// import '../cart/components/check_out_card.dart';

class OrderDetails extends StatefulWidget {
  final OrderNum;
  const OrderDetails({super.key, required this.OrderNum});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  void initState() {
    super.initState();

    GetMyOrdersDetails();
  }

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  Future<List<dynamic>> GetMyOrdersDetails() async {
    var response = await _crud
        .postRequests(linkgeitemorder, {"orderNo": widget.OrderNum.toString()});

    return response['data'];
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              "Cart Summry",
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
            future: GetMyOrdersDetails(),
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

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    itemCount: length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                                child: Image.network(
                                    "$linkServerImage/${cart_data[index]['IMAGES']}"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Minus button

                                  SizedBox(width: 10),
                                  // Quantity display
                                  Text(
                                    cart_data[index]['OWNERNAME'].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                                  text: "\$${cart_data[index]['PROPRICE']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor),
                                  children: [
                                    TextSpan(
                                        text:
                                            " x${cart_data[index]['ORDEREDQTY']}",
                                        // text: "2",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // /////////////////////
                          // const SizedBox(width: 50),
                          const SizedBox(width: 20),
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
                                        "\$${Calculate(cart_data[index]['PROPRICE'], cart_data[index]['ORDEREDQTY'])}",
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
                );
              } else {
                return const Text('No Cart data found');
              }
              // 2451040
            }),
      ),
      // bottomNavigationBar:
      //     CheckoutCard(total_price: totalPrice, cartIdes: CartIdes),
    );
  }
}
