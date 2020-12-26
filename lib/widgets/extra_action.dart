import 'package:fire/bloc/todos/todos_bloc.dart';
import 'package:fire/bloc/todos/todos_event.dart';
import 'package:fire/bloc/todos/todos_state.dart';
import 'package:fire/models/extra_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoaded) {
          bool allComplete = state.todos.every((element) => element.complete);
          return PopupMenuButton<ExtraAction>(
            onSelected: (value) {
              switch (value) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem(
                value: ExtraAction.toggleAllComplete,
                child: Text(
                    allComplete ? 'Mark all incomplete' : 'Mark all complete'),
              ),
              PopupMenuItem(
                value: ExtraAction.clearCompleted,
                child: Text('Clear complete'),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
