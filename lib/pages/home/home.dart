import 'package:flutter/material.dart';
import 'appbar.dart';
import 'popular_products.dart';
import 'search_box.dart';
import 'top_categoris.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? selectedCategoryId;

  void _onCategorySelected(int? categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
  }

  String searchQuery = '';

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: appbar(context)),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Encuentra\nproductos de calidad 🌷",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 30, height: 1.4)),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: searchBox(
                  context,
                  _onSearchChanged,
                  () => _showFilterOptions(),
                ),
              ),
              TopCategorisWidget(onCategorySelected: _onCategorySelected),
              PopularProductsWidgets(
                selectedCategoryId: selectedCategoryId,
                searchQuery: searchQuery,
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
