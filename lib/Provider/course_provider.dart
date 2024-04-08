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

  final List<String> _coursename = [];

  final List<String> _timeslots = [];

  List<String> get courseTypeIndex => _courseTypeIndex;
  List<DataRow> get rows => _rows;
  List<String> get coursename => _coursename;
  List<String> get timeslots => _timeslots;

  void addRow(DataRow newRow) {
    _rows.add(newRow);
    notifyListeners();
  }

  void removeRow(int index) {
    _rows.removeAt(index);
    notifyListeners();
  }

  void addCourseName(String name) {
    _coursename.add(name);
    notifyListeners();
  }

  void removeCourseName(int index) {
    _coursename.removeAt(index);
    notifyListeners();
  }

  void addTime(String time) {
    timeslots.add(time);
    notifyListeners();
  }

  void removeTime(int index) {
    timeslots.removeAt(index);
    notifyListeners();
  }
}
