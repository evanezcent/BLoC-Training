import 'dart:async';

import 'package:fire/bloc/stat/stat_event.dart';
import 'package:fire/bloc/stat/stat_state.dart';
import 'package:fire/bloc/todos/todos_bloc.dart';
import 'package:fire/bloc/todos/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _todosSubscription;

  StatsBloc({TodosBloc todosBloc})
      : assert(todosBloc != null),
        super(StatsLoading()) {
    _todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoaded) {
        add(UpdateStats(state.todos));
      }
    });
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.todos.where((todo) => !todo.complete).toList().length;
      int numCompleted =
          event.todos.where((todo) => todo.complete).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _todosSubscription?.cancel();
    return super.close();
  }
}
