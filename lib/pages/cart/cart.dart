import 'package:flutter/material.dart';

import '../home/popular_products.dart';
import '../product/product.dart';
import 'modify_cart.dart';
import 'finish_cart.dart';

class CartView extends StatefulWidget {
  final String _title;
  const CartView(this._title, {super.key});
  @override
  State<StatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double _calculateTotal() {
    return productCounters.fold(
      0.0,
      (sum, productCounter) {
        var product =
            products.firstWhere((p) => p.id == productCounter.idProduct);
        return sum + (productCounter.count * product.salePrice);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: productCounters.length,
          itemBuilder: (context, index) {
            var productCounter = productCounters[index];
            var product =
                products.firstWhere((p) => p.id == productCounter.idProduct);

            return ListTile(
              onLongPress: () {
                removeProduct(context, productCounters[index]);
              },
              title: Text(product.name),
              subtitle: Text(
                  "\$${(productCounter.count * product.salePrice).toStringAsFixed(2)}"),
              leading: CircleAvatar(
                child: Text(productCounter.count.toString()),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ModifyCart(productCounter)))
                      .then((newProductCounter) {
                    if (newProductCounter != null) {
                      setState(() {
                        productCounter.count = newProductCounter.count;
                        print("ID del producto modificado: ${product.id}");
                      });
                    }
                  });
                },
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, bottom: 80),
            child: Text(
              "Total: \$${_calculateTotal().toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (productCounters.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: FloatingActionButton(
                onPressed: () async {
                  final bool? purchaseCompleted = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinishCart(
                        total: _calculateTotal(),
                      ),
                    ),
                  );

                  if (purchaseCompleted == true) {
                    setState(() {
                      productCounters.clear();
                    });
                  }
                },
                tooltip: "Finalizar Compra",
                child: const Icon(Icons.check),
              ),
            ),
        ],
      ),
    );
  }

  removeProduct(BuildContext context, ProductsCounter productCounter) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Eliminar Producto"),
              content:
                  Text("¿Está seguro de que quiere eliminar este producto?"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      productCounters.remove(productCounter);
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    "Eliminar",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 190, 30, 99),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ));
  }
}
