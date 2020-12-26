import 'package:fire/bloc/tab/tab_bloc.dart';
import 'package:fire/models/app_tab.dart';
import 'package:fire/widgets/extra_action.dart';
import 'package:fire/widgets/filter_button.dart';
import 'package:fire/widgets/todos_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Bloc Todos App"),
            actions: [
              FilterButton(
                visible: activeTab == AppTab.todos,
              ),
              ExtraActions()
            ],
          ),
          body: TodosTab(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/addTodo');
            },
            child: Icon(Icons.add),
            tooltip: 'Add Todo',
          ),
        );
      },
    );
  }
}
