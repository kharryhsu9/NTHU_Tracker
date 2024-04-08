import 'package:flutter/material.dart';
import 'package:nthu_tracker/Provider/course_provider.dart';
import 'package:nthu_tracker/Provider/checklists_provider.dart';
import 'package:provider/provider.dart';

class CheckListPage extends StatelessWidget {
  const CheckListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final checklistProvider = Provider.of<ChecklistProvider>(context);
    return SingleChildScrollView(
      child: Consumer<CourseProvider>(
        builder: (context, courseProvider, _) {
          return Column(
            children: courseProvider.coursename.map((courseName) {
              final courseChecklistItems =
                  checklistProvider.getChecklistItemsForCourse(courseName);
              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        courseName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courseChecklistItems.length +
                          1, // +1 for the "Add Checklist Item" button
                      itemBuilder: (context, index) {
                        if (index == courseChecklistItems.length) {
                          // This is the last item, show the "Add Checklist Item" button
                          return ElevatedButton(
                            onPressed: () {
                              checklistProvider.addCheckListItem(ChecklistItem(
                                title:
                                    'New Checklist Item ${checklistProvider.checkListItems.length + 1}',
                                checked: false,
                                courseName: courseName,
                              ));
                            },
                            child: const Text('Add Checklist Item'),
                          );
                        } else {
                          final item = courseChecklistItems[index];
                          return Dismissible(
                            key: Key(item.title),
                            onDismissed: (direction) {
                              checklistProvider.removeCheckListItem(item);
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              title: Text(
                                item.title,
                                style: TextStyle(
                                  decoration: item.checked
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              leading: Checkbox(
                                value: item.checked,
                                onChanged: (value) {
                                  checklistProvider.tickbox(value!, item);
                                },
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _editCheckListItem(context, item, index);
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _editCheckListItem(BuildContext context, ChecklistItem item, int index) {
    final checklistProvider =
        Provider.of<ChecklistProvider>(context, listen: false);
    String newText = item.title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Checklist Item'),
          content: TextField(
            controller: TextEditingController(text: newText),
            onChanged: (value) {
              newText = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                checklistProvider.editCheckListItem(item, newText);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
