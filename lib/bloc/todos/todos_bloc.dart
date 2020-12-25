import 'dart:async';

import 'package:fire/bloc/todos/todos_event.dart';
import 'package:fire/bloc/todos/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todos_repository/todos_repository.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRespository _todosRespository;
  StreamSubscription _subscription;

  TodosBloc(TodosRespository todosRespository)
      : assert(todosRespository != null),
        _todosRespository = todosRespository,
        super(TodosLoading());

  Stream<TodosState> _mapLoadtoState() async* {
    _subscription?.cancel();
    _subscription =
        _todosRespository.todos().listen((data) => add(TodosUpdated(data)));
  }

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {}
  }
}
