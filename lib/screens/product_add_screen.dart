import 'package:flutter/material.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProductAddScreenUI();
}

class ProductAddScreenUI extends State<ProductAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Product Name"),
                  hintText: "Ex. Headphone",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Product Code"),
                  hintText: "Ex. sqwggy",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Image"),
                  hintText: "Ex. Image URL",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Unit Price"),
                  hintText: "Ex. 120",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Qty"),
                  hintText: "Ex. 2",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const TextField(
                decoration: InputDecoration(
                  filled: true,
                  label: Text("Total Price"),
                  hintText: "Ex. 240",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Create Product")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
