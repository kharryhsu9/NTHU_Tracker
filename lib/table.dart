import 'package:flutter/material.dart';

class CourseTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataTable(
        columns: [
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Course Title')),
          DataColumn(label: Text('Credits')),
          DataColumn(label: Text('Time')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('Compulsory')),
            DataCell(Text('Beginning Japanese I')),
            DataCell(Text('3')),
            DataCell(Text('F2F3F4')),
          ])
        ],
      ),
    );
  }
}
