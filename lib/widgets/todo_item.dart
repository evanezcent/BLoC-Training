import 'package:flutter/material.dart';

import 'package:todos_repository/todos_repository.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged onCheckboxChange;
  final Todo todo;

  const TodoItem(
      {Key key, this.onDismissed, this.onTap, this.onCheckboxChange, this.todo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("__Item ID : ${todo.id}"),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(value: todo.complete, onChanged: onCheckboxChange),
        title: Hero(
            tag: '${todo.id}__heroTag',
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                todo.task,
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
        subtitle: todo.note.isNotEmpty
            ? Text(
                todo.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
