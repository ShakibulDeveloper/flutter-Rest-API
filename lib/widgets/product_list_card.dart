import 'package:flutter/material.dart';
import 'package:restapi/models/product.dart';
import 'package:restapi/screens/product_add_screen.dart';

class ProductListCard extends StatelessWidget {
  final Product product;
  const ProductListCard(
      {super.key, required this.product, required this.onPressedProductDelete});

  final Function(String) onPressedProductDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return productCardDialogAction(context);
            });
      },
      child: Card(
        child: ExpansionTile(
          expandedAlignment: Alignment.topLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          leading: Image.network(
            product.img,
            fit: BoxFit.contain,
          ),
          title: Text(product.productName),
          subtitle: Row(
            children: [
              Text('Qty: ${product.qty}',
                  style: Theme.of(context).textTheme.bodySmall),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text("Unit Price: \$${product.unitPrice}",
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("\$${product.totalPrice}"),
              Text("Total Price", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description",
                      style: Theme.of(context).textTheme.bodySmall),
                  Text("Product Code: ${product.productCode}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //======PRODUCT_LIST_CARD_ACTION=======
  AlertDialog productCardDialogAction(context) {
    return AlertDialog(
      title: const Text("Select Option"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Update"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductAddScreen(product: product)));
            },
          ),
          Divider(height: 0),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text("Delete"),
            onTap: () {
              Navigator.pop(context);
              onPressedProductDelete(product.id);
            },
          ),
        ],
      ),
    );
  }
}
