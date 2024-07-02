// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
// import 'package:shop_app/models/Product.dart';

import '../../components/crud.dart';
import '../../constant/linkapi.dart';
import '../details/details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  static String routeName = "/products";

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
              future: Get_Product(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("No products"),
                  );
                  // return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final product_data = snapshot.data!;
                  final length = product_data.length;
                  return GridView.builder(
                    itemCount: length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => ProductCard(
                      product: product_data[index],
                      onPress: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        arguments: ProductDetailsArguments(
                            product: product_data[index]),
                      ),
                    ),
                  );
                } else {
                  return const Text('No product data found');
                }
              }),
        ),
      ),
    );
  }
}
