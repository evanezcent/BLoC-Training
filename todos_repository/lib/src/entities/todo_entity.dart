import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  TodoEntity(this.complete, this.id, this.note, this.task);

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
    };
  }

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'TodoEntity { complete: $complete, task: $task, note: $note, id: $id }';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json["complete"] as bool,
      json["id"] as String,
      json["note"] as String,
      json["task"] as String,
    );
  }

  static TodoEntity fromSnapshot(DocumentSnapshot snap) {
    return TodoEntity(
      snap.data()['complete'],
      snap.id,
      snap.data()['note'],
      snap.data()['task'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
    };
  }
}
