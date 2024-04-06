import 'package:flutter/material.dart';
import 'package:nthu_tracker/Model/row.dart';
import 'package:nthu_tracker/Model/time_check.dart'; // Import the time_check.dart file containing the parseTime function

class NewRow extends StatefulWidget {
  const NewRow({super.key, required this.onAddRow});

  final void Function(
      String type, String courseName, String credit, String time) onAddRow;

  @override
  State<NewRow> createState() => _NewRowState();
}

class _NewRowState extends State<NewRow> {
  final _nameController = TextEditingController();
  final _creditController = TextEditingController();
  final _timeController = TextEditingController();
  TypeCourse _selectedType = TypeCourse.compul;
  final _formKey = GlobalKey<FormState>();

  String _customType = '';

  @override
  void dispose() {
    _nameController.dispose();
    _creditController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _submitRowData() {
    final type = (_selectedType == TypeCourse.others
        ? _customType
        : _selectedType.index.toString());
    final name = _nameController.text;
    final credit = _creditController.text;
    final time = _timeController.text;
    if (_formKey.currentState!.validate()) {
      widget.onAddRow(type, name, credit, time);
      Navigator.pop(context);
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please fill the text.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  final List<String> _courseType = [
    "Compulsory",
    "General Education Course",
    "Department Required",
    "Basic Core Courses",
    "Core Courses",
    "Professional Courses",
    "Free Eleective Course",
    "Others",
  ];

  void _submitCustomTypeDialog() {
    if (_customType.isEmpty) {
      _showDialog();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Type',
                      style: TextStyle(fontSize: 16),
                    ),
                    DropdownButton<TypeCourse>(
                      value: _selectedType,
                      items: TypeCourse.values.map((type) {
                        final index = TypeCourse.values.indexOf(type);
                        return DropdownMenuItem<TypeCourse>(
                          value: type,
                          child: Text(
                            _courseType[index],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedType = value;
                          if (_selectedType == TypeCourse.others) {
                            _showCustomTypeDialog();
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: _selectedType == TypeCourse.others ? true : false,
                  child: Text(
                    ': $_customType',
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('Course Name'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid course name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _creditController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Credits'),
              ),
              validator: (value) {
                if (value!.isEmpty ||
                    double.tryParse(value) == null ||
                    int.tryParse(value)! < 0) {
                  return 'Please enter a valid credits';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: const InputDecoration(
                label: Text('Time'),
              ),
              validator: (value) {
                return parseTime(value!, context) == ''
                    ? null
                    : parseTime(value, context);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitRowData,
                  child: const Text('Save'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomTypeDialog() {
    _customType = '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter Custom Type'),
        content: TextField(
          onChanged: (value) {
            setState(() {
              _customType = value;
            });
          },
          decoration: const InputDecoration(labelText: 'Custom Type'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _submitCustomTypeDialog();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
