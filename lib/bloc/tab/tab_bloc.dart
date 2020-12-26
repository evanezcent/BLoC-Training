import 'package:fire/bloc/tab/tab_event.dart';
import 'package:fire/models/app_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}
