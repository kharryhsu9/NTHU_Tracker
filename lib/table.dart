import 'package:flutter/material.dart';
import 'package:nthu_tracker/new_row.dart';

class CourseTable extends StatefulWidget {
  const CourseTable({Key? key}) : super(key: key);

  @override
  _CourseTableState createState() => _CourseTableState();
}

class _CourseTableState extends State<CourseTable> {
  final List<DataRow> _rows = [
    const DataRow(
      cells: [
        DataCell(
          Text('Professional Courses', style: TextStyle(fontSize: 14)),
        ),
        DataCell(
          Text(
            'Introduction to Data Analytics and Machine Learning',
            style: TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        ),
        DataCell(
          Text('3', style: TextStyle(fontSize: 14)),
        ),
        DataCell(
          Text('F9FaFb', style: TextStyle(fontSize: 14)),
        ),
      ],
    ),
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
      _rows.add(
        DataRow(
          cells: [
            DataCell(
              Text(type, style: const TextStyle(fontSize: 14)),
            ),
            DataCell(
              Text(courseName, style: const TextStyle(fontSize: 14)),
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
