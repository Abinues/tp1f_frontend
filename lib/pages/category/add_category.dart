import 'package:flutter/material.dart';
import 'category.dart';
import '../text_box.dart';

class AddCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCategory();
}

class _AddCategory extends State<AddCategory> {
  late TextEditingController controllerName;

  @override
  void initState() {
    controllerName = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Categoría"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Nombre"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;

                if (name.isNotEmpty) {
                  Navigator.pop(context, new Category(name: name));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Text("Guardar Categoría")),
        ],
      ),
    );
  }
}
