import 'package:flutter/material.dart';

import '../../components/crud.dart';
import '../../components/product_card.dart';
import '../../constant/linkapi.dart';
import '../details/details_screen.dart';

class CatItem extends StatefulWidget {
  final catdata;
  const CatItem({super.key, required this.catdata});

  static String routeName = "/catItem";

  @override
  State<CatItem> createState() => _CatItemState();
}

class _CatItemState extends State<CatItem> {
  String cat_id = "";
  String cat_name = "";

  void initState() {
    super.initState();

    cat_id = widget.catdata['CATEGID'];
    cat_name = widget.catdata['CATEGORIES'];
    Get_Product_Cat();
  }

  // ignore: prefer_final_fields
  Crud _crud = Crud();

  Future<List<dynamic>> Get_Product_Cat() async {
    var response = await _crud
        .postRequests(linkgetitemsbycat, {"cat_id": cat_id.toString()});

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat_name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
              future: Get_Product_Cat(),
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
