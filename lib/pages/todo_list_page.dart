import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_list_item.dart';


class TodoListPage extends StatefulWidget {
   TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
   final TextEditingController todoController = TextEditingController();

   List<Todo> todos = [];
   Todo? deletedTodo;
   int? deletedTodoPos;

   @override
   Widget build(BuildContext context) {
     return SafeArea(
       child: Scaffold(
         body: Center(
           child: Padding(
             padding:  EdgeInsets.all(16),
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Text(
                   'Lista de Tarefas',
                   style: TextStyle(
                     fontSize: 25,
                     fontWeight: FontWeight.w700,

                   ),
                 ),
                 // ======================================================
                 SizedBox(height: 20),
                 Row(
                   children: [
                     Expanded(             // expande até ocupar o máximo de largura disponível
                       child: TextField(
                         controller: todoController,
                         decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           labelText: 'Adicione uma tarefa',
                           hintText: 'Ex: Estudar Flutter',
                         ),
                       ),
                     ),
                     SizedBox(width: 8),
                     ElevatedButton(
                          onPressed: () {
                            String text = todoController.text;
                            setState(() {
                              Todo newTodo = Todo(
                                title: text,
                                dateTime: DateTime.now(),
                              );
                              todos.add(newTodo);
                            });
                            todoController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                             backgroundColor: Color(0xff00d7f3),
                             padding: EdgeInsets.all(14),
                          ),
                         child: Icon(
                           Icons.add,
                           size: 30,
                         )
                     ),
                   ],
                 ),
                 // =================================================================
                 SizedBox(height: 20),
                 Flexible(
                   child: ListView(
                      shrinkWrap: true,    // tamanho da lista segue a qtd de itens da lista
                      children:  [
                        for(Todo todo in todos)
                          TodoListItem(
                            todo: todo,
                            onDelete: onDelete,
                          ),
                     ],
                   ),
                 ),
                 // ==================================================
                 SizedBox(height:16),
                 Row(
                   children:  [
                     Expanded(
                       child: Text(
                         'Você possui ${todos.length} tarefas pendentes',
                       ),
                     ),
                     SizedBox(width: 8),
                     ElevatedButton(
                         onPressed: showDeleteTodosConfirmationDialog,
                         style: ElevatedButton.styleFrom(
                         backgroundColor: Color(0xff00d7f3),
                         padding: EdgeInsets.all(14),
                         ),
                         child: Text(
                             ('Limpar tudo'),
                         ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       ),
     );
   }

   void onDelete(Todo todo){
     deletedTodo = todo;                         // guardar item da lista
     deletedTodoPos = todos.indexOf(todo);       // guardar posição do item

     setState(() {
       todos.remove(todo);
     });

     ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Tarefa ${todo.title} removida com sucesso!'),
         action: SnackBarAction(
           label: 'Desfazer',
           onPressed: (){
             setState(() {
               todos.insert(deletedTodoPos!, deletedTodo!);
             });
           },
         ),
         duration: const Duration(seconds: 5),
       ),
     );
   }

   void showDeleteTodosConfirmationDialog(){
     showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: Text('Limpar tudo?'),
           content: Text('Você tem certeza que deseja apagar todas as tarefas?'),
           actions: [
             TextButton(
                 onPressed: (){
                   Navigator.of(context).pop();   // fecha o diálogo
                 },
                  style: TextButton.styleFrom(
                      foregroundColor: Color(0xff00d7f3),
                  ),
                 child: Text('Cancelar'),
             ),

             TextButton(
                 onPressed: (){
                   Navigator.of(context).pop();   // fecha o diálogo
                   DeleteAllTodos();
                 },
               style: TextButton.styleFrom(
                 foregroundColor: Colors.red,
               ),
                 child: Text('Limpar tudo'),
             ),
           ],
         ),
     );
   }

   void DeleteAllTodos(){
     setState(() {
       todos.clear();
     });
   }

}

