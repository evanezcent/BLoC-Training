import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/model/vaccination.dart';

class Pet {
  String name;
  String notes;
  String type;
  List<Vaccination> vaccinations = List<Vaccination>();
  DocumentReference reference;

  Pet(this.name, {this.notes, this.type, this.reference, this.vaccinations});
  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    Pet newPet = Pet.fromJson(snapshot.data());
    newPet.reference = snapshot.reference;
    return newPet;
  }

  Pet.fromJson(Map<String, dynamic> json) {
    this.name = json['name'] as String;
    this.notes = json['notes'] as String;
    this.type = json['type'] as String;
    this.vaccinations = json['vaccinations'] as List;
  }
  Map<String, dynamic> toJson() => _PetToJson(this);
  @override
  String toString() => "Pet<$name>";

  List<Vaccination> _convertVaccinations(List vaccinationMap) {
    if (vaccinationMap == null) {
      return null;
    }
    List<Vaccination> vaccinations = List<Vaccination>();
    vaccinationMap.forEach((value) {
      vaccinations.add(Vaccination.fromJson(value));
    });
    return vaccinations;
  }

  Map<String, dynamic> _PetToJson(Pet instance) => <String, dynamic>{
        'name': instance.name,
        'notes': instance.notes,
        'type': instance.type,
        'vaccinations': _VaccinationList(instance.vaccinations),
      };

  List<Map<String, dynamic>> _VaccinationList(List<Vaccination> vaccinations) {
    if (vaccinations == null) {
      return null;
    }
    List<Map<String, dynamic>> vaccinationMap = List<Map<String, dynamic>>();
    vaccinations.forEach((vaccination) {
      vaccinationMap.add(vaccination.toJson());
    });
    return vaccinationMap;
  }
}
