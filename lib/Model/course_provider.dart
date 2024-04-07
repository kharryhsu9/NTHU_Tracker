import 'package:flutter/material.dart';

class CourseProvider with ChangeNotifier {
  final List<String> _courseTypeIndex = [
    "Compulsory",
    "General Education Course",
    "Department Required",
    "Basic Core Courses",
    "Core Courses",
    "Professional Courses",
    "Free Eleective Course",
    "Others",
  ];

  final List<DataRow> _rows = [];

  List<DataRow> get rows => _rows;
  List<String> get courseTypeIndex => _courseTypeIndex;

  void addRow(DataRow newRow) {
    _rows.add(newRow);
    notifyListeners();
  }

  void removeRow(int index) {
    _rows.removeAt(index);
    notifyListeners();
  }
}
