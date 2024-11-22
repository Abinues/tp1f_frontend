import 'package:flutter/material.dart';
import 'category.dart';
import '../text_box.dart';

class AddCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddCategory();
}

class _AddCategory extends State<AddCategory> {
  late TextEditingController controllerName;
  late IconData selectedIcon;

  final List<IconData> icons = [
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.account_balance,
    Icons.account_circle,
    Icons.add_shopping_cart,
    Icons.agriculture,
    Icons.local_grocery_store,
    Icons.restaurant,
    Icons.fastfood,
    Icons.local_cafe,
    Icons.local_dining,
    Icons.icecream,
    Icons.cookie,
    Icons.bakery_dining,
    Icons.local_pizza,
    Icons.rice_bowl,
    Icons.egg,
    Icons.apple,
    Icons.grass,
    Icons.bolt,
    Icons.local_drink,
    Icons.water_drop,
    Icons.wine_bar,
    Icons.cleaning_services,
    Icons.soap,
    Icons.baby_changing_station,
    Icons.pets,
    Icons.medication,
    Icons.spa,
    Icons.kitchen,
    Icons.shopping_bag,
  ];

  @override
  void initState() {
    controllerName = TextEditingController();
    selectedIcon = icons.first;
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<IconData>(
              isExpanded: true,
              value: selectedIcon,
              items: icons
                  .map((icon) => DropdownMenuItem<IconData>(
                        value: icon,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(icon)],
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedIcon = value!;
                });
              },
              hint: Text("Seleccione un ícono"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              String name = controllerName.text;

              if (name.isNotEmpty) {
                Navigator.pop(
                  context,
                  Category(name: name, icon: selectedIcon),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Text("Guardar Categoría"),
          ),
        ],
      ),
    );
  }
}
