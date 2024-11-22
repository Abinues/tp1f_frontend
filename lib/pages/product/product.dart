import 'dart:typed_data';

import 'add_product.dart';
import 'modify_product.dart';
import 'package:flutter/material.dart';
import '../category/category.dart';
import '../home/search_box.dart';

class ProductView extends StatefulWidget {
  final String _title;
  const ProductView(this._title, {super.key});
  @override
  State<StatefulWidget> createState() => _ProductView();
}

List<Product> products = [
  // Frutas
  Product(
      name: 'Manzana',
      idCategory: 0,
      salePrice: 1.2,
      stock: 50,
      imagePath: 'lib/images/manzana.png'),
  Product(
      name: 'Banana',
      idCategory: 0,
      salePrice: 0.8,
      stock: 50,
      imagePath: 'lib/images/banana.png'),
  Product(
      name: 'Naranja',
      idCategory: 0,
      salePrice: 1.1,
      stock: 50,
      imagePath: 'lib/images/naranja.png'),

  // Verduras
  Product(
      name: 'Lechuga',
      idCategory: 1,
      salePrice: 0.5,
      stock: 50,
      imagePath: 'lib/images/lechuga.png'),
  Product(
      name: 'Tomate',
      idCategory: 1,
      salePrice: 0.9,
      stock: 50,
      imagePath: 'lib/images/tomate.png'),
  Product(
      name: 'Zanahoria',
      idCategory: 1,
      salePrice: 0.7,
      stock: 50,
      imagePath: 'lib/images/zanahoria.png'),

  // Lácteos
  Product(
      name: 'Leche',
      idCategory: 2,
      salePrice: 1.0,
      stock: 50,
      imagePath: 'lib/images/leche.png'),
  Product(
      name: 'Queso',
      idCategory: 2,
      salePrice: 2.5,
      stock: 50,
      imagePath: 'lib/images/queso.png'),
  Product(
      name: 'Yogurt',
      idCategory: 2,
      salePrice: 1.2,
      stock: 50,
      imagePath: 'lib/images/yogurt.png'),

  // Carnes
  Product(
      name: 'Pollo',
      idCategory: 3,
      salePrice: 5.0,
      stock: 50,
      imagePath: 'lib/images/pollo.png'),
  Product(
      name: 'Carne de Res',
      idCategory: 3,
      salePrice: 7.5,
      stock: 50,
      imagePath: 'lib/images/carne.png'),
  Product(
      name: 'Cerdo',
      idCategory: 3,
      salePrice: 6.0,
      stock: 50,
      imagePath: 'lib/images/cerdo.png'),

  // Pescado
  Product(
      name: 'Salmón',
      idCategory: 4,
      salePrice: 12.0,
      stock: 50,
      imagePath: 'lib/images/salmon.png'),
  Product(
      name: 'Atún',
      idCategory: 4,
      salePrice: 9.5,
      stock: 50,
      imagePath: 'lib/images/atun.png'),

  // Panadería
  Product(
      name: 'Pan de Molde',
      idCategory: 5,
      salePrice: 1.5,
      stock: 50,
      imagePath: 'lib/images/pan.png'),
  Product(
      name: 'Croissant',
      idCategory: 5,
      salePrice: 1.2,
      stock: 50,
      imagePath: 'lib/images/croissant.png'),

  // Bebidas
  Product(
      name: 'Agua',
      idCategory: 6,
      salePrice: 0.8,
      stock: 50,
      imagePath: 'lib/images/agua.png'),
  Product(
      name: 'Jugo de Naranja',
      idCategory: 6,
      salePrice: 1.5,
      stock: 50,
      imagePath: 'lib/images/jugo.png'),
  Product(
      name: 'Refresco',
      idCategory: 6,
      salePrice: 1.0,
      stock: 50,
      imagePath: 'lib/images/refresco.png'),

  // Snacks
  Product(
      name: 'Papas Fritas',
      idCategory: 7,
      salePrice: 1.3,
      stock: 50,
      imagePath: 'lib/images/papasfritas.png'),
  Product(
      name: 'Chocolate',
      idCategory: 7,
      salePrice: 1.7,
      stock: 50,
      imagePath: 'lib/images/chocolate.png'),

  // Cereales
  Product(
      name: 'Avena',
      idCategory: 8,
      salePrice: 2.0,
      stock: 50,
      imagePath: 'lib/images/avena.png'),
  Product(
      name: 'Cornflakes',
      idCategory: 8,
      salePrice: 2.2,
      stock: 50,
      imagePath: 'lib/images/cereal.png'),

  // Condimentos
  Product(
      name: 'Sal',
      idCategory: 9,
      salePrice: 0.6,
      stock: 50,
      imagePath: 'lib/images/sal.png'),
  Product(
      name: 'Pimienta',
      idCategory: 9,
      salePrice: 0.7,
      stock: 50,
      imagePath: 'lib/images/pimienta.png')
];

class _ProductView extends State<ProductView> {
  List<Product> filteredProducts = products;
  String currentFilter = 'name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          searchBox(context, _filterProducts, _showFilterOptions),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final categoryName = categories.any(
                        (cat) => cat.id == filteredProducts[index].idCategory)
                    ? categories
                        .firstWhere((cat) =>
                            cat.id == filteredProducts[index].idCategory)
                        .name
                    : 'Sin Categoría';
                return ListTile(
                  onLongPress: () {
                    removeProduct(context, filteredProducts[index]);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(filteredProducts[index].name),
                      Text(
                        "\$${filteredProducts[index].salePrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  subtitle: Text(
                      '$categoryName | Stock: ${filteredProducts[index].stock}'),
                  leading: CircleAvatar(
                    backgroundImage: filteredProducts[index].imageBytes != null
                        ? MemoryImage(filteredProducts[index].imageBytes!)
                        : (filteredProducts[index].imagePath != null
                            ? AssetImage(filteredProducts[index].imagePath!)
                            : null),
                    child: (filteredProducts[index].imageBytes == null &&
                            filteredProducts[index].imagePath == null)
                        ? Text(filteredProducts[index].name.substring(0, 1))
                        : null,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ModifyProduct(filteredProducts[index])),
                      ).then((newProduct) {
                        if (newProduct != null) {
                          setState(() {
                            filteredProducts[index].name = newProduct.name;
                            filteredProducts[index].salePrice =
                                newProduct.salePrice;
                            filteredProducts[index].idCategory =
                                newProduct.idCategory;
                          });
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddProduct()),
            ).then((newProduct) {
              if (newProduct != null) {
                setState(() {
                  products.add(newProduct);
                  filteredProducts = products;
                });
              }
            });
          },
          tooltip: "Agregar Producto",
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.sort_by_alpha),
                title: Text('Filtrar por nombre'),
                onTap: () {
                  setState(() => currentFilter = 'name');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: Text('Filtrar por categoría'),
                onTap: () {
                  setState(() => currentFilter = 'category');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterProducts(String query) {
    setState(() {
      if (currentFilter == 'name') {
        filteredProducts = products
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else if (currentFilter == 'category') {
        filteredProducts = products.where((product) {
          final category = categories.firstWhere(
              (cat) => cat.id == product.idCategory,
              orElse: () => Category(name: '', icon: Icons.error));
          return category.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  removeProduct(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Eliminar Producto"),
        content: Text(
            "¿Está seguro de que quiere eliminar el producto ${product.name}?"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                products.remove(product);
                filteredProducts = products;
                Navigator.pop(context);
              });
            },
            child: Text(
              "Eliminar",
              style: TextStyle(color: const Color.fromARGB(255, 190, 30, 99)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

class Product {
  static int _idCounter = 0;
  int id;
  String name;
  int idCategory;
  double salePrice;
  int stock;
  String? imagePath;
  Uint8List? imageBytes;

  Product({
    required this.name,
    required this.idCategory,
    required this.salePrice,
    required this.stock,
    this.imagePath,
    this.imageBytes,
  }) : id = _idCounter++;
}
