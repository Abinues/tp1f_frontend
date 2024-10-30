import 'package:flutter/material.dart';

import '../cart/finish_cart.dart';

import '../product/product.dart';

class SaleDetailView extends StatelessWidget {
  final Sale sale;

  SaleDetailView(this.sale, {super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de la Venta"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sale.detalle.length,
              itemBuilder: (context, index) {
                final product = products.firstWhere(
                  (prod) => prod.id == sale.detalle[index].idProduct,
                );

                final quantity = sale.detalle[index].count;
                final totalPrice = product.salePrice * quantity;

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("\$${totalPrice.toStringAsFixed(2)}"),
                  leading: CircleAvatar(
                    child: Text(quantity.toString()),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Total de la compra: \$${sale.total.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
