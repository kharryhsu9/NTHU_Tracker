import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nthu_tracker/Provider/course_provider.dart';
import 'package:nthu_tracker/Table%20Page/new_row.dart';
import 'package:nthu_tracker/Model/table_info.dart';
import 'package:provider/provider.dart';

class CourseTable extends StatefulWidget {
  const CourseTable({Key? key}) : super(key: key);

  @override
  _CourseTableState createState() => _CourseTableState();
}

class _CourseTableState extends State<CourseTable> {
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

  void _openAddRowOverlay(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      useSafeArea: true,
      builder: (ctx) => NewRow(onAddRow: _addRow),
    );
  }

  void _addRow(
    String type,
    String courseName,
    String credit,
    String time,
  ) {
    setState(() {
      var typeInt = int.tryParse(type);
      var typeText = typeInt != null ? _courseTypeIndex[typeInt] : type;
      final courseProvider =
          Provider.of<CourseProvider>(context, listen: false);
      final newRow = DataRow(
        cells: [
          DataCell(
            Text(typeText, style: const TextStyle(fontSize: 12)),
          ),
          DataCell(
            Text(
              courseName,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              softWrap: true,
            ),
          ),
          DataCell(
            Text(credit, style: const TextStyle(fontSize: 12)),
          ),
          DataCell(
            Text(time, style: const TextStyle(fontSize: 12)),
          ),
        ],
      );
      courseProvider.addRow(newRow);
      courseProvider.addCourseName(courseName);
      updateTable(courseName, time);
      courseProvider.addTime(time);
    });
  }

  void _removeRow(int index) {
    setState(() {
      final courseProvider =
          Provider.of<CourseProvider>(context, listen: false);
      courseProvider.removeRow(index);
      courseProvider.removeCourseName(index);
      updateTable('', courseProvider.timeslots[index]);
      courseProvider.removeTime(index);
      Navigator.of(context).pop();
    });
  }

  void _showOptionsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletion for Row ${index + 1}'),
          content: const Text('Do you want to remove this row?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _removeRow(index);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Consumer<CourseProvider>(
            builder: (context, courseProvider, _) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  alignment: Alignment.center,
                  child: DataTable(
                    headingRowHeight: 60,
                    dataRowMaxHeight: double.infinity,
                    columnSpacing: 15,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Type',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Course Title',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Credits',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Time',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                    rows: courseProvider.rows
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            cells: [
                              for (var cell in entry.value.cells)
                                DataCell(
                                  GestureDetector(
                                    onTap: () =>
                                        _showOptionsDialog(context, entry.key),
                                    child: cell.child,
                                  ),
                                ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
          IconButton(
            onPressed: () => _openAddRowOverlay(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
