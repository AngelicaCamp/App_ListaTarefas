import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key,required this.todo, required this.onDelete}) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:2),
      child: Slidable(
        key: Key('$todo'),
        endActionPane: ActionPane(
          motion:  StretchMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(todo);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Excluir',
            ),
            SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Editar',
            ),
          ],
        ),


        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,   // posicionar na esquerda
            children:  [
              Text(
                DateFormat('dd/MM/yyyy').format(todo.dateTime),
                style: TextStyle(
                fontSize: 12,
              ),),
              Text(
                todo.title,
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),),
            ],
          ),
        ),
      ),
    );
  }

}

