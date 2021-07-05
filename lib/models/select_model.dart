import 'package:flutter/material.dart';
import 'package:website/models/categories_model.dart';

class SelectModel {
  Category value;
  bool isSelected;
  SelectModel({
    @required this.value,
    @required this.isSelected,
  });
}
