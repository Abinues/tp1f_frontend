import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

import 'home/home.dart';
import 'category/category.dart';
import 'product/product.dart';
import 'cart/cart.dart';
import 'sale/sale.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currnetPageIndex = 0;
  _handleIndexChanged(int i) {
    setState(() {
      _currnetPageIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pagesList = [
      const HomePage(),
      const CartView('Carrito'),
      const ProductView('Productos'),
      const CategoryView('Categorías'),
      const SaleView('Ventas'),
    ];
    return Scaffold(
      body: _pagesList[_currnetPageIndex],
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        paddingR: const EdgeInsets.symmetric(horizontal: 4),
        marginR: const EdgeInsets.symmetric(horizontal: 40),
        margin: const EdgeInsets.only(left: 10, right: 10),
        dotIndicatorColor: Colors.white,
        unselectedItemColor: Colors.pink[300],
        currentIndex: _currnetPageIndex,
        splashBorderRadius: 50,
        onTap: _handleIndexChanged,
        items: [
          DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: Theme.of(context).colorScheme.onPrimary),
          DotNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              selectedColor: Theme.of(context).colorScheme.onPrimary),
          DotNavigationBarItem(
              icon: const Icon(Icons.add_shopping_cart_outlined),
              selectedColor: Theme.of(context).colorScheme.onPrimary),
          DotNavigationBarItem(
              icon: const Icon(Icons.add_business_outlined),
              selectedColor: Theme.of(context).colorScheme.onPrimary),
          DotNavigationBarItem(
              icon: const Icon(Icons.price_check),
              selectedColor: Theme.of(context).colorScheme.onPrimary),
        ],
      ),
    );
  }
}
