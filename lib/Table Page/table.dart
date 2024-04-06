import 'package:flutter/material.dart';
import 'package:nthu_tracker/Model/row.dart';
import 'package:nthu_tracker/Table%20Page/new_row.dart';
import 'package:nthu_tracker/Model/table_info.dart';
import 'package:provider/provider.dart';

class CourseTable extends StatefulWidget {
  const CourseTable({Key? key}) : super(key: key);

  @override
  _CourseTableState createState() => _CourseTableState();
}

class _CourseTableState extends State<CourseTable> {
  final List<DataRow> _rows = [];

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
      _rows.add(
        DataRow(
          cells: [
            DataCell(
              Text(typeText, style: const TextStyle(fontSize: 14)),
            ),
            DataCell(
              Text(
                courseName,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: true,
              ),
            ),
            DataCell(
              Text(credit, style: const TextStyle(fontSize: 14)),
            ),
            DataCell(
              Text(time, style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
      );
      updateTable(courseName, time);
      //sent courseName and time to file overview.dart
    });
  }

  void _removeRow(int index) {
    setState(() {
      _rows.removeAt(index);
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

  void _addSampleRow() {
    _addRow(
      "5", // Type index for "Professional Courses"
      "Sample Course", // Course name
      "3", // Credits
      "F9FaFb", // Time
    );
  }

  @override
  void initState() {
    super.initState();
    _addSampleRow(); // Add the sample row when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SingleChildScrollView(
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
                rows: _rows
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
