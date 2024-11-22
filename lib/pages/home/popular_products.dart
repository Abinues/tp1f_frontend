import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import '../product/product.dart';

class ProductsCounter {
  int idProduct;
  int count;

  ProductsCounter({required this.idProduct, this.count = 0});

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 0) count--;
  }
}

class PopularProductsWidgets extends StatefulWidget {
  final int? selectedCategoryId;
  final String searchQuery;

  const PopularProductsWidgets(
      {super.key, this.selectedCategoryId, this.searchQuery = ''});

  @override
  State<PopularProductsWidgets> createState() => _PopularProductsWidgetsState();
}

List<ProductsCounter> productCounters = [];

class _PopularProductsWidgetsState extends State<PopularProductsWidgets> {
  void _incrementCounter(int productId) {
    setState(() {
      var productCounter = productCounters.firstWhere(
        (counter) => counter.idProduct == productId,
        orElse: () {
          final newCounter = ProductsCounter(idProduct: productId);
          productCounters.add(newCounter);
          return newCounter;
        },
      );

      final product = products.firstWhere((p) => p.id == productId);

      if (product.stock > 0) {
        productCounter.increment();
        product.stock--;
      }
    });
  }

  void _decrementCounter(int productId) {
    setState(() {
      var productCounter = productCounters.firstWhere(
        (counter) => counter.idProduct == productId,
        orElse: () => ProductsCounter(idProduct: productId),
      );

      if (productCounter.count > 0) {
        productCounter.decrement();

        final product = products.firstWhere((p) => p.id == productId);
        product.stock++;
      }

      if (productCounter.count == 0) {
        productCounters
            .removeWhere((counter) => counter.idProduct == productId);
      }
    });
  }

  List<Product> get filteredProducts {
    var filtered = widget.selectedCategoryId == null
        ? products
        : products
            .where((product) => product.idCategory == widget.selectedCategoryId)
            .toList();

    if (widget.searchQuery.isNotEmpty) {
      filtered = filtered
          .where((product) => product.name
              .toLowerCase()
              .contains(widget.searchQuery.toLowerCase()))
          .toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: Text(
          "Productos",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      Container(
        width: MediaQuery.sizeOf(context).width,
        height: 600,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: filteredProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 320,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            final currentCount = productCounters
                .firstWhere(
                  (counter) => counter.idProduct == product.id,
                  orElse: () => ProductsCounter(idProduct: product.id),
                )
                .count;

            return InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: product.imageBytes != null
                              ? ClipOval(
                                  child: Image.memory(
                                    product.imageBytes!,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 200,
                                  ),
                                )
                              : product.imagePath != null
                                  ? ClipOval(
                                      child: kIsWeb
                                          ? Image.asset(
                                              product.imagePath!,
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 200,
                                            )
                                          : Image.file(
                                              File(product.imagePath!),
                                              fit: BoxFit.cover,
                                              width: 200,
                                              height: 200,
                                            ),
                                    )
                                  : Center(
                                      child: Text(
                                        product.name[0],
                                        style: TextStyle(
                                          fontSize: 80,
                                          color: Colors.pink.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Text(
                          currentCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Text(
                          "S: ${product.stock}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 3),
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Text(
                      "\$${product.salePrice.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _decrementCounter(product.id),
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: product.stock > 0
                            ? () => _incrementCounter(product.id)
                            : null,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ]);
  }
}
