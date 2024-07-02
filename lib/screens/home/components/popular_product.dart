// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../components/crud.dart';
import '../../../components/product_card.dart';
import '../../../constant/linkapi.dart';
// import '../../../models/Product.dart';
import '../../details/details_screen.dart';
import '../../products/products_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({super.key});

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  void initState() {
    super.initState();
    Get_Product();
  }

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  Future<List<dynamic>> Get_Product() async {
    var response = await _crud.getRequests(linkgetitems);

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, ProductsScreen.routeName);
            },
          ),
        ),
        FutureBuilder(
            future: Get_Product(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("No products"),
                );
                // return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final product_data = snapshot.data!;
                final length = product_data.length;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ProductCard(
                            product: product_data[index],
                            onPress: () => Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: ProductDetailsArguments(
                                  product: product_data[index]),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(width: 20),
                    ],
                  ),
                );
              } else {
                return Text('No product data found');
              }
            }),
      ],
    );
  }
}




