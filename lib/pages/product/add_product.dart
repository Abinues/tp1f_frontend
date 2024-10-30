import '../product/product.dart';
import 'package:flutter/material.dart';
import '../text_box.dart';

import '../category/category.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  late TextEditingController controllerName;
  late TextEditingController controllerPrice;

  int? selectedCategoryId;

  @override
  void initState() {
    controllerName = new TextEditingController();
    controllerPrice = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Producto"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Nombre"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonFormField<int>(
              value: selectedCategoryId,
              onChanged: (int? newValue) {
                setState(() {
                  selectedCategoryId = newValue!;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0,
                    ),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                labelText: "Categoría",
                suffixIcon: GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () {
                    setState(() {
                      selectedCategoryId = null;
                    });
                  },
                ),
              ),
            ),
          ),
          TextBox(controllerPrice, "Precio de Venta"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;
                double? price = double.tryParse(controllerPrice.text);

                if (name.isNotEmpty &&
                    price != null &&
                    selectedCategoryId != null) {
                  Navigator.pop(
                    context,
                    Product(
                      name: name,
                      idCategory: selectedCategoryId!,
                      salePrice: price,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary),
              child: Text("Guardar Producto")),
        ],
      ),
    );
  }
}
