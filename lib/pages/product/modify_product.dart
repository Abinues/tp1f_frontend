import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'product.dart';
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
  late TextEditingController controllerStock;
  int? selectedCategoryId;
  String? imagePath;
  Uint8List? imageBytes;

  @override
  void initState() {
    Product p = widget._product;
    controllerName = TextEditingController(text: p.name);
    controllerPrice = TextEditingController(text: p.salePrice.toString());
    controllerStock = TextEditingController(text: p.stock.toString());
    selectedCategoryId = p.idCategory;
    imagePath = p.imagePath;
    imageBytes = p.imageBytes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Producto"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextBox(controllerName, "Nombre"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
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
          TextBox(controllerStock, "Stock"),
          SizedBox(height: 16),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: imageBytes != null
                  ? Image.memory(
                      imageBytes!,
                      fit: BoxFit.cover,
                    )
                  : imagePath != null
                      ? (kIsWeb
                          ? Image.asset(
                              imagePath!,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath!),
                              fit: BoxFit.cover,
                            ))
                      : Center(child: Text("Seleccionar Imagen")),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String name = controllerName.text;
              double? price = double.tryParse(controllerPrice.text);
              int? stock = int.tryParse(controllerStock.text);

              if (name.isNotEmpty &&
                  price != null &&
                  stock != null &&
                  selectedCategoryId != null) {
                widget._product.name = name;
                widget._product.salePrice = price;
                widget._product.stock = stock;
                widget._product.idCategory = selectedCategoryId!;
                widget._product.imagePath = kIsWeb ? null : imagePath;
                widget._product.imageBytes = kIsWeb ? imageBytes : null;
                Navigator.pop(context, widget._product);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Por favor, completa todos los campos"),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Text("Guardar Producto"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      if (kIsWeb) {
        setState(() {
          imagePath = null;
          imageBytes = result.files.single.bytes;
        });
      } else {
        setState(() {
          imagePath = result.files.single.path;
          imageBytes = null;
        });
      }
    } else {
      setState(() {
        imagePath = null;
        imageBytes = null;
      });
    }
  }
}
