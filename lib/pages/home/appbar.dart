import 'package:flutter/material.dart';

Widget appbar(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "",
        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
      ),
    ],
  );
}
