import 'package:flutter/material.dart';
import '../text_box.dart';
import '../home/popular_products.dart';

class ModifyCart extends StatefulWidget {
  final ProductsCounter _productCounter;
  ModifyCart(this._productCounter);

  @override
  State<StatefulWidget> createState() => _ModifyCart();
}

class _ModifyCart extends State<ModifyCart> {
  late TextEditingController controllerCount;

  @override
  void initState() {
    ProductsCounter p = widget._productCounter;
    controllerCount = TextEditingController(text: p.count.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar Carrito"),
      ),
      body: ListView(
        children: [
          TextBox(controllerCount, "Cantidad"),
          ElevatedButton(
            onPressed: () {
              String countText = controllerCount.text;
              int? count = int.tryParse(countText);

              if (count != null && count > 0) {
                widget._productCounter.count = count;
                Navigator.pop(context, widget._productCounter);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Ingrese una cantidad válida")),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary),
            child: Text("Guardar Cantidad"),
          ),
        ],
      ),
    );
  }
}
