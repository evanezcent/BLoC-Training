import 'package:fire/bloc/filtered/filtered_bloc.dart';
import 'package:fire/bloc/stat/stat_bloc.dart';
import 'package:fire/bloc/tab/tab_bloc.dart';
import 'package:fire/bloc/todos/todos_bloc.dart';
import 'package:fire/bloc/todos/todos_event.dart';
import 'package:fire/screens/add_screen.dart';
import 'package:fire/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:todos_repository/todos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserver();
  await Firebase.initializeApp();
  runApp(TodosApp());
}

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(
        todosRespository: FirebaseTodoRepo(),
      )..add(LoadTodos()),
      child: MaterialApp(
        title: 'Bloc Todos App',
        routes: {
          '/': (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<TabBloc>(
                  create: (context) => TabBloc(),
                ),
                BlocProvider<FilteredTodosBloc>(
                  create: (context) => FilteredTodosBloc(
                    todosBloc: BlocProvider.of<TodosBloc>(context),
                  ),
                ),
                BlocProvider<StatsBloc>(
                  create: (context) => StatsBloc(
                    todosBloc: BlocProvider.of<TodosBloc>(context),
                  ),
                ),
              ],
              child: HomeScreen(),
            );
          },
          '/addTodo': (context) {
            return AddEditScreen(
              onSave: (task, note) {
                BlocProvider.of<TodosBloc>(context).add(
                  AddTodo(Todo(task, note: note)),
                );
              },
              isEditing: false,
            );
          },
        },
      ),
    );
  }
}
