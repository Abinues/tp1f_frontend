import '../category/add_category.dart';
import '../category/modify_category.dart';
import '../home/search_box.dart';
import 'package:flutter/material.dart';

class CategoryView extends StatefulWidget {
  final String _title;
  const CategoryView(this._title, {super.key});
  @override
  State<StatefulWidget> createState() => _CategoryView();
}

List<Category> categories = [
  Category(name: 'Fruta', icon: Icons.apple),
  Category(name: 'Verdura', icon: Icons.grass),
  Category(name: 'Lácteos', icon: Icons.icecream),
  Category(name: 'Carnes', icon: Icons.food_bank),
  Category(name: 'Pescado', icon: Icons.set_meal),
  Category(name: 'Panadería', icon: Icons.bakery_dining),
  Category(name: 'Bebidas', icon: Icons.local_drink),
  Category(name: 'Snacks', icon: Icons.fastfood),
  Category(name: 'Cereales', icon: Icons.rice_bowl),
  Category(name: 'Condimentos', icon: Icons.spa)
];

class _CategoryView extends State<CategoryView> {
  List<Category> filteredCategories = categories;
  String selectedFilter = 'name';
  bool isFilteringByName = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          searchBox(
            context,
            _filterCategories,
            _showFilterOptions,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onLongPress: () {
                    removeCategory(context, filteredCategories[index]);
                  },
                  title: Text(filteredCategories[index].name),
                  leading: CircleAvatar(
                    child: Icon(filteredCategories[index].icon),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ModifyCategory(filteredCategories[index]),
                        ),
                      ).then((newCategory) {
                        if (newCategory != null) {
                          setState(() {
                            filteredCategories[index] = newCategory;
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
              MaterialPageRoute(builder: (_) => AddCategory()),
            ).then((newCategory) {
              if (newCategory != null) {
                setState(() {
                  categories.add(newCategory);
                  filteredCategories = categories;
                });
              }
            });
          },
          tooltip: "Agregar Categoría",
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
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _filterCategories(String query) {
    setState(() {
      if (selectedFilter == 'name') {
        filteredCategories = categories
            .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  removeCategory(BuildContext context, Category category) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Eliminar Categoría"),
        content: Text("Está seguro de que quiere eliminar la categoría " +
            category.name +
            "?"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                categories.remove(category);
                filteredCategories = categories;
                Navigator.pop(context);
              });
            },
            child: Text(
              "Eliminar",
              style: TextStyle(
                color: const Color.fromARGB(255, 190, 30, 99),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class Category {
  static int _idCounter = 0;
  int id;
  var name;
  IconData icon;

  Category({required this.name, required this.icon}) : id = _idCounter++;
}
