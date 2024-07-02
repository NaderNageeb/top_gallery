// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shop_app/screens/products/cat_item.dart';

import '../../../components/crud.dart';
import '../../../constant/linkapi.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  void initState() {
    super.initState();
    Get_category();
  }

  Crud _crud = Crud();

  Future<List<dynamic>> Get_category() async {
    var response = await _crud.getRequests(linkgetcat);

    return response['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
          future: Get_category(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color(0xFFFFA53E),
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Text("No Categorys"),
              );
              // return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final category_data = snapshot.data!;
              final length = category_data.length;
              return SingleChildScrollView(
                // controller: controller,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ...List.generate(
                      length,
                      (index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFFA53E),
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CatItem(
                                            catdata: category_data[index],
                                          )));
                                },
                                child: Text(
                                  category_data[index]['CATEGORIES'].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Text('No category data found');
            }
          }),
    );
  }
}



























// Original Code
// return Padding(
//       padding: const EdgeInsets.all(10),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [],
//         ),
//       ),
//     );