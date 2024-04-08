import 'package:flutter/material.dart';

class ChecklistProvider extends ChangeNotifier {
  final List<ChecklistItem> _checkListItems = [];

  List<ChecklistItem> get checkListItems => _checkListItems;

  List<List<ChecklistItem>> courseCheckLists = [];

  void addCheckListItem(ChecklistItem item) {
    _checkListItems.add(item);
    notifyListeners();
  }

  void removeCheckListItem(ChecklistItem item) {
    _checkListItems.remove(item);
    notifyListeners();
  }

  void editCheckListItem(ChecklistItem item, String newText) {
    item.title = newText;
    notifyListeners();
  }

  void tickbox(bool value, ChecklistItem item) {
    item.checked = value;
    notifyListeners();
  }

  List<ChecklistItem> getChecklistItemsForCourse(String courseName) {
    List<ChecklistItem> itemsForCourse = [];
    for (var item in _checkListItems) {
      if (item.courseName == courseName) {
        itemsForCourse.add(item);
      }
    }
    return itemsForCourse;
  }
}

class ChecklistItem {
  String title;
  bool checked;
  String courseName;

  ChecklistItem(
      {required this.title, required this.checked, required this.courseName});
}
