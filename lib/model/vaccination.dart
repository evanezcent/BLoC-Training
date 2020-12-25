import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  
  String vaccination;
  DateTime date;
  bool done;
  DocumentReference reference;
  Vaccination(this.vaccination, {this.date, this.done, this.reference});

  Vaccination.fromJson(Map<dynamic, dynamic> json) {
    Vaccination(
      json['vaccination'] as String,
      date: json['date'] == null ? null : (json['date'] as Timestamp).toDate(),
      done: json['done'] as bool,
    );
  }

  Map<String, dynamic> toJson() => _VaccinationToJson(this);
  @override
  String toString() => "Vaccination<$vaccination>";

  Map<String, dynamic> _VaccinationToJson(Vaccination instance) =>
      <String, dynamic>{
        'vaccination': instance.vaccination,
        'date': instance.date,
        'done': instance.done,
      };
}
