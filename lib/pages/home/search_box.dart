import 'package:flutter/material.dart';

Widget searchBox(BuildContext context, Function(String) onChanged,
    VoidCallback onFilterIconPressed) {
  return SizedBox(
    height: 50,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.pink.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              prefixIcon: Icon(Icons.search, color: Colors.pink[400]),
              hintText: "Búsqueda",
              hintStyle: TextStyle(color: Colors.pink[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.tune, color: Colors.white),
            onPressed: onFilterIconPressed,
          ),
        ),
      ],
    ),
  );
}
