import '../category/category.dart';
import 'package:flutter/material.dart';
import '../text_box.dart';

class ModifyCategory extends StatefulWidget {
  final Category _category;
  ModifyCategory(this._category);
  @override
  State<StatefulWidget> createState() => _ModifyCategory();
}

class _ModifyCategory extends State<ModifyCategory> {
  late TextEditingController controllerName;

  @override
  void initState() {
    Category c = widget._category;
    controllerName = new TextEditingController(text: c.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Categoría"),
      ),
      body: ListView(
        children: [
          TextBox(controllerName, "Nombre"),
          ElevatedButton(
              onPressed: () {
                String name = controllerName.text;

                if (name.isNotEmpty) {
                  widget._category.name = name;
                  Navigator.pop(context, widget._category);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary),
              child: Text("Guardar Categoría")),
        ],
      ),
    );
  }
}
