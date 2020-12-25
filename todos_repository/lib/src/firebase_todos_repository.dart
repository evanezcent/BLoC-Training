import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/entities.dart';
import 'models/todo_model.dart';
import 'todos_repository.dart';

class FirebaseTodoRepo implements TodosRespository {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addNewTodo(Todo todo) {
    return todoCollection.add(todo.todoEntity().toDocument());
  }

  @override
  Future<void> deleteTodo(Todo todo) {
    return todoCollection.doc(todo.id).delete();
  }

  @override
  Stream<List<Todo>> todos() {
    return todoCollection.snapshots().map((data) {
      return data.docs
          .map((mainData) => Todo.fromEntity(TodoEntity.fromSnapshot(mainData)))
          .toList();
    });
  }

  @override
  Future<void> updateTodo(Todo newData) {
    return todoCollection
        .doc(newData.id)
        .update(newData.todoEntity().toDocument());
  }
}
