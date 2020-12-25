import 'models/model.dart';

abstract class TodosRespository {
  Stream<List<Todo>> todos();
  Future<void> addNewTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
}
