import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/firestore_service.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final FirestoreService firestoreService;

  const TodoItem({
    super.key,
    required this.todo,
    required this.firestoreService,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        todo.task,
        style: TextStyle(
          decoration:
          todo.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      value: todo.isDone,
      onChanged: (_) => firestoreService.updateTodoStatus(
        todo.id,
        todo.isDone,
      ),
    );
  }
}