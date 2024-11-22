import 'package:flutter/material.dart';
import 'delivery_map_view.dart';
import 'geocoding.dart';
import '../cart/finish_cart.dart';

import '../product/product.dart';

class SaleDetailView extends StatelessWidget {
  final Sale sale;

  SaleDetailView(this.sale, {super.key});

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
                  title: Text(
                    "$quantity ${product.name}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                  ),
                  leading: CircleAvatar(
                    backgroundImage: product.imageBytes != null
                        ? MemoryImage(product.imageBytes!)
                        : (product.imagePath != null
                            ? AssetImage(product.imagePath!)
                            : null),
                    child:
                        product.imageBytes == null && product.imagePath == null
                            ? Text(
                                product.name[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
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
      floatingActionButton: sale.operation != "pickup"
          ? Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: FloatingActionButton(
                onPressed: () async {
                  try {
                    Map<String, double> coordinates =
                        await getCoordinatesFromAddress(sale.operation);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeliveryMapView(
                          latitude: coordinates['latitude']!,
                          longitude: coordinates['longitude']!,
                        ),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                },
                tooltip: "Ver Ubicación",
                child: const Icon(Icons.map),
              ),
            )
          : null,
    );
  }
}
