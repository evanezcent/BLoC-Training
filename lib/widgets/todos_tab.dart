import 'package:fire/bloc/filtered/filtered_bloc.dart';
import 'package:fire/bloc/filtered/filtered_state.dart';
import 'package:fire/bloc/todos/todos_bloc.dart';
import 'package:fire/bloc/todos/todos_event.dart';
import 'package:fire/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FilteredTodosLoaded) {
          final todos = state.filteredTodos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              TodoItem(
                todo: todos[index],
                onDismissed: (direction) {
                  BlocProvider.of<TodosBloc>(context)
                      .add(DeleteTodo(todos[index]));
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Deleted ${todos[index].task}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: "Undo",
                        onPressed: () => BlocProvider.of<TodosBloc>(context)
                            .add(AddTodo(todos[index]))),
                  ));
                },
                onTap: () async {
                  // final removedTodo = await Navigator.of(context).push(route)
                },
                onCheckboxChange: (value) {
                  BlocProvider.of<TodosBloc>(context).add(UpdateTodo(
                      todos[index].copyWith(complete: !todos[index].complete)));
                },
              );
            },
          );
        }
      },
    );
  }
}
