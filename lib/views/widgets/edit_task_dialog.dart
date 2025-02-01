import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTaskDialog extends StatefulWidget {
  final String? initialName;
  final String? initialDescription;
  final DateTime? initialDueDate;
  final void Function(String name, String description, DateTime dueDate) onSave;

  const EditTaskDialog({
    required this.onSave, super.key,
    this.initialName,
    this.initialDescription,
    this.initialDueDate,
  });

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _dueDateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _descriptionController = TextEditingController(text: widget.initialDescription ?? '');
    _dueDateController = TextEditingController(text: widget.initialDueDate != null ? DateFormat('dd MM yyyy').format(widget.initialDueDate!) : '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initialName != null ? 'Edit Task' : 'Create Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _dueDateController,
            decoration: const InputDecoration(labelText: 'Due Date'),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: widget.initialDueDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                _dueDateController.text = DateFormat('dd MM yyyy').format(pickedDate);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave(
              _nameController.text,
              _descriptionController.text,
              DateFormat('dd MM yyyy').parse(_dueDateController.text),
            );
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}