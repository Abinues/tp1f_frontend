import 'product.dart';
import 'package:flutter/material.dart';
import '../text_box.dart';
import '../category/category.dart';

class ModifyProduct extends StatefulWidget {
  final Product _product;
  ModifyProduct(this._product);
  @override
  State<StatefulWidget> createState() => _ModifyProduct();
}

class _ModifyProduct extends State<ModifyProduct> {
  late TextEditingController controllerName;
  late TextEditingController controllerPrice;
  int? selectedCategoryId;

  @override
  void initState() {
    Product p = widget._product;
    controllerName = TextEditingController(text: p.name);
    controllerPrice = TextEditingController(text: p.salePrice.toString());
    selectedCategoryId = p.idCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Producto"),
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
                widget._product.name = name;
                widget._product.salePrice = price;
                widget._product.idCategory = selectedCategoryId!;
                Navigator.pop(context, widget._product);
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary),
            child: Text("Guardar Producto"),
          ),
        ],
      ),
    );
  }
}
