import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapi/models/product.dart';
import 'package:restapi/screens/product_add_screen.dart';
import 'package:restapi/widgets/product_list_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenUI();
}

class HomeScreenUI extends State<HomeScreen> {
  bool inProgress = false;
  List<Product> productList = [];

  Future<void> getProductList() async {
    Response response =
        await get(Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'));

    if (response.statusCode == 200) {
      inProgress = true;
      setState(() {});

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        for (Map<String, dynamic> eachProduct in responseData['data']) {
          productList.add(Product(
              eachProduct['_id'],
              eachProduct['ProductName'],
              eachProduct['ProductCode'],
              eachProduct['Img'],
              eachProduct['UnitPrice'],
              eachProduct['Qty'],
              eachProduct['TotalPrice']));
        }
        inProgress = false;
        setState(() {});
      }
    }
  }

  Future<void> deleteProduct(String productID) async {
    inProgress = true;
    setState(() {});

    Response response = await get(Uri.parse(
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productID'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      productList.clear();
      getProductList();
    }

    inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          IconButton(
              onPressed: () {
                productList.clear();
                getProductList();
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductAddScreen()));
        },
        child: const Icon(Icons.create),
      ),
      body: inProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductListCard(
                  product: productList[index],
                  onPressedProductDelete: deleteProduct,
                );
              }),
    );
  }
}
