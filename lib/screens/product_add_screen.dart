import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapi/models/product.dart';

class ProductAddScreen extends StatefulWidget {
  final Product? product;
  const ProductAddScreen({super.key, this.product});

  @override
  State<StatefulWidget> createState() => ProductAddScreenUI();
}

class ProductAddScreenUI extends State<ProductAddScreen> {
  bool inProgress = false;

  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _productImageTEController =
      TextEditingController();
  final TextEditingController _productUnitPriceTEController =
      TextEditingController();
  final TextEditingController _productQuantityTEController =
      TextEditingController();
  final TextEditingController _productTotalPriceTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> addProduct() async {
    inProgress = true;
    setState(() {});

    Map<String, dynamic> inputMap = {
      "Img": _productImageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "ProductName": _productNameTEController.text.trim(),
      "Qty": _productQuantityTEController.text.trim(),
      "TotalPrice": _productTotalPriceTEController.text.trim(),
      "UnitPrice": _productUnitPriceTEController.text.trim()
    };

    Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode(inputMap));

    if (response.statusCode == 200) {
      _productImageTEController.clear();
      _productCodeTEController.clear();
      _productNameTEController.clear();
      _productQuantityTEController.clear();
      _productTotalPriceTEController.clear();
      _productUnitPriceTEController.clear();
    }
    inProgress = false;
    setState(() {});
  }

  Future<void> updateProduct() async {
    inProgress = true;
    setState(() {});

    Map<String, dynamic> inputMap = {
      "Img": _productImageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "ProductName": _productNameTEController.text.trim(),
      "Qty": _productQuantityTEController.text.trim(),
      "TotalPrice": _productTotalPriceTEController.text.trim(),
      "UnitPrice": _productUnitPriceTEController.text.trim()
    };

    Response response = await post(
        Uri.parse(
            'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}'),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode(inputMap));

    inProgress = false;
    setState(() {});
  }

  @override
  void initState() {
    if (widget.product != null) {
      _productImageTEController.text = widget.product!.img;
      _productCodeTEController.text = widget.product!.productCode;
      _productNameTEController.text = widget.product!.productName;
      _productQuantityTEController.text = widget.product!.qty;
      _productTotalPriceTEController.text = widget.product!.totalPrice;
      _productUnitPriceTEController.text = widget.product!.unitPrice;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.product != null
            ? const Text("Update Product")
            : const Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: inProgress
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      TextFormField(
                        controller: _productNameTEController,
                        decoration: const InputDecoration(
                          filled: true,
                          label: Text("Product Name"),
                          hintText: "Ex. Headphone",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: inputValidation,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _productCodeTEController,
                        decoration: const InputDecoration(
                          filled: true,
                          label: Text("Product Code"),
                          hintText: "Ex. sqwggy",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: inputValidation,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _productImageTEController,
                        decoration: const InputDecoration(
                          filled: true,
                          label: Text("Image"),
                          hintText: "Ex. Image URL",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: inputValidation,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _productUnitPriceTEController,
                        decoration: const InputDecoration(
                          filled: true,
                          label: Text("Unit Price"),
                          hintText: "Ex. 120",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: inputValidation,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _productQuantityTEController,
                        decoration: const InputDecoration(
                          filled: true,
                          label: Text("Qty"),
                          hintText: "Ex. 2",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: inputValidation,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _productTotalPriceTEController,
                        decoration: const InputDecoration(
                          filled: true,
                          label: Text("Total Price"),
                          hintText: "Ex. 240",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: inputValidation,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (widget.product != null) {
                                  updateProduct();
                                } else {
                                  addProduct();
                                }
                              }
                            },
                            child: widget.product != null
                                ? const Text("Update Product")
                                : const Text("Create Product")),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  String? inputValidation(String? value) {
    if (value?.trim().isNotEmpty ?? false) {
      return null;
    } else {
      return "Please fill-up the input field.";
    }
  }
}
