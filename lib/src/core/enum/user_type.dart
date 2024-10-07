import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum UserType {
  merchant(
    title: "Merchant",
    icon: Symbols.shopping_basket_rounded,
    id: 2,
    value: "merchant",
  ),
  customer(
    title: "Customer",
    icon: Symbols.store_rounded,
    id: 3,
    value: "customer",
  );

  final String title;
  final IconData icon;
  final int id;
  final String value;

  const UserType({
    required this.title,
    required this.icon,
    required this.id,
    required this.value,
  });
}
