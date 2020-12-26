import 'dart:async';

import 'package:fire/bloc/todos/todos_event.dart';
import 'package:fire/bloc/todos/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todos_repository/todos_repository.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRespository _todosRepository;
  StreamSubscription _subscription;

  TodosBloc(TodosRespository todosRespository)
      : assert(todosRespository != null),
        _todosRepository = todosRespository,
        super(TodosLoading());

  Stream<TodosState> _mapLoadtoState() async* {
    _subscription?.cancel();
    _subscription =
        _todosRepository.todos().listen((data) => add(TodosUpdated(data)));
  }

  Stream<TodosState> _mapAddTodotoState(AddTodo event) async* {
    _todosRepository.addNewTodo(event.todo);
  }

  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    _todosRepository.updateTodo(event.updatedTodo);
  }

  Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
    _todosRepository.deleteTodo(event.todo);
  }

  Stream<TodosState> _mapAllToggletoState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final allComplete =
          currentState.todos.every((element) => element.complete);
      final List<Todo> updatedTodos = currentState.todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();

      updatedTodos.forEach((element) {
        _todosRepository.updateTodo(element);
      });
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final List<Todo> completedTodos =
          currentState.todos.where((todo) => todo.complete).toList();
      completedTodos.forEach((completedTodo) {
        _todosRepository.deleteTodo(completedTodo);
      });
    }
  }

  Stream<TodosState> _mapTodosUpdateToState(TodosUpdated event) async* {
    yield TodosLoaded(event.todos);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadtoState();
    } else if (event is AddTodo) {
      yield* _mapAddTodotoState(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodoToState(event);
    } else if (event is ToggleAll) {
      yield* _mapAllToggletoState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdateToState(event);
    }
  }
}
