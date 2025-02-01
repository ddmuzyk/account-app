import 'package:dsw_52745/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget taskTile({
  required String title,
  required String description,
  required DateTime dueDate,
  required VoidCallback onDelete,
  required VoidCallback onEdit,
}) {
  final formattedDate = DateFormat('dd MM yyyy').format(dueDate);

  return Card(
    color: MyColors.purple3,
    child: ListTile(
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description),
          const SizedBox(height: 2),
          Text(
            'Due date: $formattedDate',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    ),
  );
}
