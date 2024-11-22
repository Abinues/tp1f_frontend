import 'dart:io';
import 'dart:typed_data';
import '../product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../text_box.dart';
import '../category/category.dart';
import 'package:file_picker/file_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  late TextEditingController controllerName;
  late TextEditingController controllerPrice;
  late TextEditingController controllerStock;

  int? selectedCategoryId;
  String? imagePath;
  Uint8List? imageBytes;

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerPrice = TextEditingController();
    controllerStock = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Producto"),
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
          TextBox(controllerStock, "Stock Inicial"),
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
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                        )
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
                Navigator.pop(
                  context,
                  Product(
                    name: name,
                    idCategory: selectedCategoryId!,
                    salePrice: price,
                    stock: stock,
                    imagePath: kIsWeb ? null : imagePath,
                    imageBytes: kIsWeb ? imageBytes : null,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Por favor, completa todos los campos")),
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
