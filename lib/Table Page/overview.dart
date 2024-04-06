import 'package:flutter/material.dart';
import 'package:nthu_tracker/Model/table_info.dart';

class CourseOverview extends StatefulWidget {
  @override
  _CourseOverviewState createState() => _CourseOverviewState();
}

class _CourseOverviewState extends State<CourseOverview> {
  final List<String> specialPeriod = ['a', 'b', 'c'];
  final List<String> days = ['M', 'T', 'W', 'R', 'F', 'S', 'U'];

  @override
  void initState() {
    super.initState();
    initializeCells();
  }

  void initializeCells() {
    for (int i = 0; i < 13; i++) {
      dataTable.add(List<String>.generate(7, (index) => ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 100, height: 50),
                      for (var day in days)
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.grey[200],
                          child: Center(child: Text(day)),
                        ),
                    ],
                  ),
                  for (var i = 0; i < 13; i++)
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          color: Colors.grey[200],
                          child: Center(
                            child: i > 9
                                ? Text(specialPeriod[i - 10])
                                : Text('$i'),
                          ),
                        ),
                        for (var j = 0; j < 7; j++)
                          GestureDetector(
                            onTap: () {
                              _showEditDialog(context, i, j);
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
                              ),
                              child: Center(
                                child: Text(
                                  dataTable[i][j],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int rowIndex, int colIndex) {
    String value = dataTable[rowIndex][colIndex];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Cell'),
          content: TextField(
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
            },
            controller: TextEditingController(text: value),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  dataTable[rowIndex][colIndex] = value;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
