import 'package:flutter/material.dart';
import '../category/category.dart';

class TopCategorisWidget extends StatefulWidget {
  final ValueChanged<int?> onCategorySelected;

  const TopCategorisWidget({super.key, required this.onCategorySelected});

  @override
  State<TopCategorisWidget> createState() => _TopCategorisWidgetState();
}

class _TopCategorisWidgetState extends State<TopCategorisWidget> {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "Categorías",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          height: 40,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.builder(
            itemCount: categories.length,
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    setState(() {
                      currentIndex = currentIndex == index ? -1 : index;
                    });

                    widget.onCategorySelected(
                      currentIndex == -1 ? null : categories[currentIndex].id,
                    );
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: currentIndex == index
                          ? Theme.of(context).colorScheme.onPrimary
                          : Colors.pink,
                    ),
                    child: Center(
                      child: Icon(
                        categories[index].icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
