import 'package:flutter/material.dart';

class NewRow extends StatefulWidget {
  const NewRow({super.key, required this.onAddRow});

  final void Function(
      String type, String courseName, String credit, String time) onAddRow;

  @override
  State<NewRow> createState() => _NewRowState();
}

class _NewRowState extends State<NewRow> {
  final _typeController = TextEditingController();
  final _nameController = TextEditingController();
  final _creditController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _typeController.dispose();
    _nameController.dispose();
    _creditController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _submitRowData() {
    final type = _typeController.text;
    final name = _nameController.text;
    final credit = _creditController.text;
    final time = _timeController.text;

    if (type.isEmpty || name.isEmpty || credit.isEmpty || time.isEmpty) {
      _showDialog();
    } else {
      widget.onAddRow(type, name, credit, time);
      Navigator.pop(context);
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please fill all the text.'),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _typeController,
            decoration: const InputDecoration(labelText: 'Type'),
          ),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Course Name'),
          ),
          TextFormField(
            controller: _creditController,
            decoration: const InputDecoration(labelText: 'Credits'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: _timeController,
            decoration: const InputDecoration(labelText: 'Time'),
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
    );
  }
}
